extends Node2D

var txtLines = GlobalScript.get_adventofcode_file_content(2023, 3)
var testString = ".....664..$."
var linesInfos = []
var currentPosition = 0
var sumNumbers = 0

func _ready():
	for line: String in txtLines:
		linesInfos.append(getNumbersInfo(line))
		checkIfPreviousLineNumbersValid()
		currentPosition += 1

	sumValidNumbers()
	print(sumNumbers) # Part 1 answer: 509115

func getNumbersInfo(line):
	# It will stack data gather from the line
	var lineInfo = {
		numbers = [], # {number: 664, startPos: 5, endPos: 8, isValid: false}
		symbols = [], # Simply an array of positions
	}
	
	var position = 0
	var shouldBeNumberUpdateNextIteration = false;
	for caracter in line:
		# Skip if it's a dot
		if(caracter == "."): 
			position +=1
			shouldBeNumberUpdateNextIteration = false
			continue
			
		if(caracter.is_valid_int()):
			if(shouldBeNumberUpdateNextIteration):
				var lastNumberRef = lineInfo.numbers[len(lineInfo.numbers) - 1];
				lastNumberRef.number += caracter
				lastNumberRef.endPos = position
				pass
			else:
				lineInfo.numbers.append({ "number": caracter, "startPos": position, "endPos": position, "isValid": false })
				
			shouldBeNumberUpdateNextIteration = true
		else:
			# Add symbol position to symbols list
			lineInfo.symbols.append(position)
			shouldBeNumberUpdateNextIteration = false
		
		position +=1
		
	return lineInfo
	
func checkIfPreviousLineNumbersValid():
	# Skip the first iteration check
	if(len(linesInfos) <= 1): return
	var previousLineInfos = linesInfos[currentPosition - 1]
	var currentLineInfos = linesInfos[currentPosition]
	checkLineWith(previousLineInfos, currentLineInfos)
	checkLineWith(currentLineInfos, previousLineInfos)

func checkLineWith(mainLineTocheck, otherLineUseToCheckTheMain):
	# Check Previous line
	for mainLineNumber in mainLineTocheck.numbers:
		if(mainLineNumber.isValid): continue # Skip this check if already valid
		
		# Check with symbol on the same line (PreviousLine)
		for previousLineSymbolPosition in mainLineTocheck.symbols:
			if(abs(mainLineNumber.startPos - previousLineSymbolPosition) <= 1 || abs(mainLineNumber.endPos - previousLineSymbolPosition) <= 1): 
				mainLineNumber.isValid = true
				break # Continue to next if valid
		
		# Check with symbol on the current line (currentLineInfos)
		for otherLineSymbolPosition in otherLineUseToCheckTheMain.symbols:
			if(abs(mainLineNumber.startPos - otherLineSymbolPosition) <= 1 || abs(mainLineNumber.endPos - otherLineSymbolPosition) <= 1): 
				mainLineNumber.isValid = true
				break # Continue to next if valid

func sumValidNumbers():
	for lineInfo in linesInfos:
		for numberInfo in lineInfo.numbers:
			if(numberInfo.isValid): sumNumbers += int(numberInfo.number)


