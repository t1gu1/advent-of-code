extends Node2D

var txtLines = GlobalScript.get_adventofcode_file_content(2023, 2)
var limitPerColor = { "red": 12, "green": 13, "blue": 14 }
var sumPower = 0
var sumIds = 0

func _ready():
	for line: String in txtLines:
		var splitedToArray = line.replace(";", ",").replace(":", ",").rsplit(",")
		var id = int(splitedToArray[0])
		
		# Remove ID from array
		splitedToArray.remove_at(0)
		
		_part1(id, splitedToArray)
		_part2(splitedToArray)
		
	print("Part 1 - Sum of valid IDS: ", sumIds) # Response: 2164
	print("Part 2 - Sum of POWER: ", sumPower) # Response: 69929

func _part1(id, splitedToArray):
	var isValid = true
	
	for element in splitedToArray:
		var number = int(element)

		for color in limitPerColor:
			if(element.contains(color) && number > limitPerColor[color]):
				isValid = false
				break
	if(isValid): sumIds += id
	

func _part2(splitedToArray):
	var maxRegistredNumber = {"red": 0, "green": 0, "blue": 0}
	
	for element in splitedToArray:
		var number = int(element)

		for color in limitPerColor:
			if(element.contains(color)):
				if(maxRegistredNumber[color] < number): maxRegistredNumber[color] = number
				break
				
	sumPower += maxRegistredNumber["red"] * maxRegistredNumber["green"] * maxRegistredNumber["blue"]
