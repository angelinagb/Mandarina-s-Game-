class_name  IsoRoom  extends Node2D

signal interactable_interacted(interactable: Interactable)
@onready var room_sounds: AudioStreamPlayer = $RoomSounds

@onready var player_b: PlayerB = $Player/PlayerB

@export var room_id: String
var current_state: Dictionary = {}

func _ready(): 
	current_state = StateManager.get_room_state(room_id)
	restore_state()
		

func get_room_identifier(): return room_id

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
	

func restore_state():
	print("Lista de estados de ", room_id ," !")
	print(current_state)
	for node in get_tree().get_nodes_in_group("Con Estado"):
		print("Buscando ", node.name, "...")
		if current_state.has(node.name):
			print("Encontrado state de : ", node.name , " !")
			node.load_state(current_state[node.name])

func save_state():
	current_state = {}
	for node in get_tree().get_nodes_in_group("Con Estado"):
		current_state[node.name] = node.get_state()
	StateManager.save_room_state(room_id, current_state)
