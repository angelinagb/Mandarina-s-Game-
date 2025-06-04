class_name Puzzle extends Node

signal puzzle_result(result: bool)
signal interacted(type: String)
signal finished()

var POPUPMENU_PATH: String = "res://utils/Interact/Puzzle/puzzles 2.0/PuzzlePopUpMenu/pop_up_menu.tscn"
var popupmenu_instance

@export var item_id: String

func _ready() -> void:
	interacted.emit("puzzle")

func on_puzzle_result(result: bool):
	puzzle_result.emit(result)

func start():
	pass

func interact():
	pass
func end():
	finished.emit()
	queue_free()
