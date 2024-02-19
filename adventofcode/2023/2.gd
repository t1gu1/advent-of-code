extends Node2D

func _ready():
	var txtLines = GlobalScript.get_adventofcode_file_content(2023, 2)
	var limitPerColor = { "red": 12, "green": 13, "blue": 14 }
	var sumIds = 0
	
	for line: String in txtLines:
		var splitedToArray = line.replace(";", ",").replace(":", ",").rsplit(",")
		var id = int(splitedToArray[0])
		
		# Remove ID from array
		splitedToArray.remove_at(0)
		
		var isValid = true
		for element in splitedToArray:
			var number = int(element)

			for color in limitPerColor:
				if(element.contains(color) && number > limitPerColor[color]):
					isValid = false
					break
		
		if(isValid): sumIds += id
			
	print(sumIds) # Part1: 2164
