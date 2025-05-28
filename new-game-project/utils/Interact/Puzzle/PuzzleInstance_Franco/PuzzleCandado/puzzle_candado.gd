extends Puzzle

@onready var control = $Control
@onready var control2 = $Control2
@onready var control3 = $Control3
@onready var control4 = $Control4

var combination = [3, 1, 4, 2]

func verify_combination():
	var actual = [
		control.get_selected_number(),
		control2.get_selected_number(),
		control3.get_selected_number(),
		control4.get_selected_number()
	]
	on_puzzle_result(actual == combination)
	queue_free()

func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		verify_combination()
	
func on_puzzle_result(result: bool):
	super.on_puzzle_result(result)
