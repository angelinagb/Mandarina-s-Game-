class_name Puzzle extends Node

signal puzzle_result(result: bool)
signal interacted 

func _ready() -> void:
	interacted.emit("puzzle")
	

func on_puzzle_result(result: bool):
	puzzle_result.emit(result)
	
	
func start():
	pass

func interact():
	pass
