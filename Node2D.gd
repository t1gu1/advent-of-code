extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	_advent_of_code_1()
	pass # Replace with function body.

# Get file content lines
func _get_adventofcode_file_content(day):
	var file = FileAccess.open(str("res://adventofcode/2023/", day, ".txt"), FileAccess.READ)
	
	var lines = []
	
	while not file.eof_reached(): 
		lines.append(file.get_line())
		
	return lines
	
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
	
func transformTxtNumberToNumber(line: String, isRecursion = false):
	var numbersFound = {}

	for txt in txtNumbersMapped:
		var pos = line.find(txt)
		if(pos != -1): 
			numbersFound[pos] = txt
		
	for txtpos in numbersFound:
		var pos = line.find(numbersFound[txtpos], txtpos + 1)
		if(pos != -1): 
			numbersFound[pos] = numbersFound[txtpos]
	
	for pos in range(0, 60):
		if(numbersFound.has(pos)):
			# lol simply replace the first caracter
			line = line.erase(pos, 1).insert(pos, txtNumbersMapped[numbersFound[pos]])
			
	return line
	
func _advent_of_code_1():
	var txtLines = _get_adventofcode_file_content(1)
	var numbersSum = 0

	for line in txtLines:
		var numbers = int(transformTxtNumberToNumber(line))
		var strNumbers = str(numbers)
		numbersSum += int(strNumbers[0] + strNumbers[-1])
		
	print(numbersSum) # 55651

