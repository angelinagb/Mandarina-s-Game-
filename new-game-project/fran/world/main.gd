extends Node2D
@onready var rm = $room_manager
@onready var player = $Player

@export var current: Room

func _ready():
	# rm.load_room(0)
	# rm.set_current(0)
	
	var scene = preload("res://rooms/room_1.tscn")
	rm.set_current_2(scene)
	
	current = rm.get_current()
	
	player.move_to(current.getPositionSpawn(""))
	
func _on_room_manager_changed_current_room(entered_from: String) -> void:
	current = rm.get_current()
	player.move_to(current.getPositionSpawn(entered_from))

func _on_room_manager_dialogue_ended() -> void:
	player.resume_player()

func _on_room_manager_item_grabbed(itemId: int) -> void:
	player.pause_player()
