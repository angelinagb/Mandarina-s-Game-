class_name Transitioner extends Interactable
#ROOM 4: AULA 01
#ROOM 5: CAFETERIA 
#ROOM 6: LABO DE QUIMICA 
var door_blocked_notification =  preload("res://Ange/door_blocked_notification.tscn")
@export_enum("ROOM-4", "ROOM-5", "ROOM-6","ROOM-LABOSYH",
 "ROOM-PASILLO1","ROOM-LABOFISICA","ROOM-ENTRADA",
"ROOM-PASILLO2","ROOM-SALACOMUN","ROOM-CENTROALUMNOS",
"ROOM-SALA-CAMARAS","VACIO","ROOM-PISO2A","ROOM-BEDELIA","ROOM-201")
var room_id: String = "VACIO"
@onready var door_sound_open: AudioStreamPlayer = $door_sound_open
@export var quest: Quest
@export var necesary_key:= false
@onready var label: Label = $Label
@export var to_room_name : String = "to-room"

func _ready():
	my_type = "transitioner"
	super._ready()
	
func get_room_id():
	return room_id
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "PlayerB":
		InteractionManager.set_interactuable(self)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "PlayerB":
		InteractionManager.clear_interactuable(self)


func interact() :
		interacted.emit(self)
		
func get_type():
	return my_type
	
func get_to_room_name() -> String:
	return to_room_name
	
func take_room_quest():
	pass
