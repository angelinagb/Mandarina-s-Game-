class_name  IsoRoom  extends Node2D

signal interactable_interacted(interactable: Interactable)
@export var room_identifier: String

func _ready(): pass

func get_room_identifier(): return room_identifier

func get_position_spawn(name_spawn: String) -> Vector2:
	for child in $Spawns.get_children():
		if child is Marker2D and child.name == name_spawn:
			return child.position
	return $Spawns/defect.position

func _on_interactable_interacted(interactable: Interactable):
	interactable_interacted.emit(interactable)
	print("disparando señal...")
