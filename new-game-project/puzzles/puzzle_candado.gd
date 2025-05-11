extends Node2D

signal puzzle_result(result: bool)

var world
@onready var control = $Control
@onready var control2 = $Control2
@onready var control3 = $Control3
@onready var control4 = $Control4

var combination = [3, 1, 4, 2]

func add_father(world: Node):
	self.world = world

func verify_combination():
	var actual = [
		control.get_selected_number(),
		control2.get_selected_number(),
		control3.get_selected_number(),
		control4.get_selected_number()
	]
	world.process_mode = Node.PROCESS_MODE_ALWAYS
	print(actual)
	if actual == combination:
		puzzle_result.emit(true)
	else:
		puzzle_result.emit(false)
	queue_free()

func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		verify_combination()
	
