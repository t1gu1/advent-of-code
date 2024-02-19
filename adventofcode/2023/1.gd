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

func _ready():
	var txtLines = GlobalScript.get_adventofcode_file_content(2023, 1)
	var numbersSum = 0

	for line in txtLines:
		var numbers = int(transformTxtNumberToNumber(line))
		var strNumbers = str(numbers)
		numbersSum += int(strNumbers[0] + strNumbers[-1])
		
	print(numbersSum) # 55651
