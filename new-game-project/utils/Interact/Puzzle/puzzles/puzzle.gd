class_name Puzzle extends CanvasLayer

signal puzzle_result(result: bool)
signal interacted(type: String)
signal finished()

var POPUPMENU_PATH: String ="res://utils/Interact/Puzzle/puzzles/PuzzlePopUpMenu/pop_up_menu.tscn"
var popupmenu_instance

@export var item_id: String

func _ready() -> void:
	interacted.emit("puzzle")

func on_puzzle_result(result: bool):
	#if result:
		#var inventory_manager = get_node("/root/Main/World/InventoryManager")
		##inventory_manager.item_grabbed(item_id)
	puzzle_result.emit(result)

func start():
	process_mode = Node.PROCESS_MODE_ALWAYS

func interact():
	pass
func end():
	finished.emit()
	queue_free()
