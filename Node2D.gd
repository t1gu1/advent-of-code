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
	var totalCaracters = 0
	
	#if(!isRecursion): print("avant:   ", line)
	#else: print("seconde: ", line)
	
	for txt in txtNumbersMapped:
		var pos = line.find(txt)
		if(pos != -1): 
			numbersFound[pos] = txt
			totalCaracters += len(txt)
		
	for txtpos in numbersFound:
		var pos = line.find(numbersFound[txtpos], txtpos + 1)
		if(pos != -1): 
			numbersFound[pos] = numbersFound[txtpos]
			totalCaracters += len(numbersFound[txtpos])
		
	#print(numbersFound)
	#if(line == "twone"): 
		#print(line)
		#print("numbersFound: ", numbersFound)
	
	var numbersFoundInOrder = []
	var range
	
	if (!isRecursion): range = range(0, 60)
	else: range = range(60, 0, -1)
	
	#if(line == "7seven9"): print(range)
	#if(len("nineigth") >= len(line)): print(line)
	if(!isRecursion && line.find("twone") != -1): print(line)
	#if(!isRecursion && len(numbersFound) == 2): print(line)
	
	for pos in range:
		#print("iiii: ", i) 
		#print('numbersFound: ', numbersFound)
		if(numbersFound.has(pos)): 
			line = line.erase(pos, len(numbersFound[pos])).insert(pos, txtNumbersMapped[numbersFound[pos]])
			if(isRecursion || len(line) <= totalCaracters): break
			
		
	#for txt in numbersFoundInOrder:
		##print('THETXT: ', txt)
		#var pos = line.find(txt)
		#line = line.erase(pos, len(txt)).insert(pos, txtNumbersMapped[txt])
	
	
	
	if(!isRecursion): transformTxtNumberToNumber(line, true)
	#else: 
		#print("Après:   ", line)
		#print(" ")
		
	return line
	
func _advent_of_code_1():
	var txtLines = _get_adventofcode_file_content(1)
	var numbersSum = 0

	for line in txtLines:
		var numbers = int(transformTxtNumberToNumber(line))
		var strNumbers = str(numbers)
		numbersSum += int(strNumbers[0] + strNumbers[-1])
		
	print(numbersSum)

# 54983 too low
# 55504
# 55203
# 55680
# 55782
# 55231
# 55782
# 55783
# 55651
