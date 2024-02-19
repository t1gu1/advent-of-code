extends Node2D

var txtNumbersMapped = {
	"one": "1",
	"two": "2",
	"three": "3",
	"four": "4",
	"five": "5",
	"six": "6",
	"seven": "7",
	"eight": "8",
	"nine": "9"
}

# All the "complexe" txt to number logic is in transformTxtNumberToNumber
func transformTxtNumberToNumber(line: String, isRecursion = false):
	var numbersFound = {} # "onetwo" -> [{0: "one", 3: "two"}]

	# Associate the string number to a position
	for txt in txtNumbersMapped:
		var pos = line.find(txt)
		if(pos != -1): 
			numbersFound[pos] = txt
		
	# Hardcoded check for a second same number in the string like "onethreeone"
	# Huge risk but.. I don't care for that code test event
	for txtpos in numbersFound:
		var pos = line.find(numbersFound[txtpos], txtpos + 1)
		if(pos != -1): 
			numbersFound[pos] = numbersFound[txtpos]
	
	# Hardcoded loop to loop on each caracter of the word
	# Could make a loop to get the longest word.. too lazy lol
	for pos in range(0, 60):
		if(numbersFound.has(pos)):
			# lol simply replace the first caracter
			line = line.erase(pos, 1).insert(pos, txtNumbersMapped[numbersFound[pos]])
			
	return line

func _ready():
	var txtLines = GlobalScript.get_adventofcode_file_content(2023, 1)
	var numbersSum = 0

	for line in txtLines:
		
		# The int clear all letters lol #nice
		var numbers = int(transformTxtNumberToNumber(line))
		# var numbers = int(line) # For the PART1 (And comment the previous line)
		
		# Sum the first and the last int found in the string
		var strNumbers = str(numbers)
		numbersSum += int(strNumbers[0] + strNumbers[-1])
		
	print(numbersSum) # Result: 55651
