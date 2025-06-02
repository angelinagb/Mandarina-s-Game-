class_name Puzzle extends Node

signal puzzle_result(result: bool)



func on_puzzle_result(result: bool):
	puzzle_result.emit(result)
	
	
func start():
	pass
