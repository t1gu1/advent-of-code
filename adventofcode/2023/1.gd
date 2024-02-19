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

# Part 2 logic
func transformTxtNumberToNumber(line: String, isRecursion = false):
	var numbersFound = {} # "onetwo" -> [{0: "one", 3: "two"}]

	# Associate the string number to a position
	for txt in txtNumbersMapped:
		var pos = line.find(txt)
		if(pos != -1): 
			numbersFound[pos] = txt

	# Check for a second same number in the string like "onethreeone"
	for txtpos in numbersFound:
		var pos = line.find(numbersFound[txtpos], txtpos + 1)
		if(pos != -1): 
			numbersFound[pos] = numbersFound[txtpos]
	
	# Loop on each caracters of the line
	for pos in len(line):
		if(numbersFound.has(pos)):
			# lol simply replace the first caracter of the text number by the number
			line = line.erase(pos, 1).insert(pos, txtNumbersMapped[numbersFound[pos]])
			
	return line

func _ready():
	var txtLines = GlobalScript.get_adventofcode_file_content(2023, 1)
	var numbersSum = 0

	for line in txtLines:
		# The int clear all letters lol #nice
		var numbers = int(transformTxtNumberToNumber(line)) # For the PART1: var numbers = int(line) 
		
		# Concat the first and the last int and sum it
		var strNumbers = str(numbers)
		numbersSum += int(strNumbers[0] + strNumbers[-1])
		
	print(numbersSum) # Result: 55652
