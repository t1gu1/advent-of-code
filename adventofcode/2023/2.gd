extends Node2D

func _ready():
	var txtLines = GlobalScript.get_adventofcode_file_content(2023, 2)

	print(txtLines) # Result: 55652
