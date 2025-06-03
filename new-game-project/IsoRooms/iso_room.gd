class_name  IsoRoom  extends Node2D

signal interactable_interacted(interactable: Interactable)

@onready var player_b: PlayerB = $Player/PlayerB

@export var room_id: String
var current_state: Dictionary = {}

@export var room_identifier: String

func _ready(): 
	current_state = StateManager.get_room_state(room_id)
	restore_state()
		

func get_room_identifier(): return room_identifier

func get_position_spawn(name_spawn: String) -> Vector2:
	for child in $Spawns.get_children():
		if child is Marker2D and child.name == name_spawn:
			return child.position
	return $Spawns/defect.position

func _on_interactable_interacted(interactable: Interactable):
	interactable_interacted.emit(interactable)
	print("disparando señal desde la room, " + "incteractuo: " + interactable.my_type)

func get_player() -> PlayerB:
	return player_b
	
func _exit_tree():
	save_state()

func restore_state():
	pass

func save_state():
	StateManager.save_room_state(room_id, current_state)
