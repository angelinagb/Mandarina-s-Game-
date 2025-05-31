class_name Puzzle extends Node2D

signal puzzle_result(result: bool)

func on_puzzle_result(result: bool):
	puzzle_result.emit(result)
	
	
#override
func start():
	pass
	
func end():
	pass
