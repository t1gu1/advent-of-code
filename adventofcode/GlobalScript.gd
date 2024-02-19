extends Node2D

func get_adventofcode_file_content(year, day):
	print(str("res://adventofcode/", year, "/", day, ".txt"))
	var file = FileAccess.open(str("res://adventofcode/", year, "/", day, ".txt"), FileAccess.READ)
	
	var lines = []
	
	while not file.eof_reached(): 
		lines.append(file.get_line())
		
	return lines
