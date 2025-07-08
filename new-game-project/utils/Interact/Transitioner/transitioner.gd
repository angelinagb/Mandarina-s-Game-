class_name Transitioner extends Interactable
#ROOM 4: AULA 01
#ROOM 5: CAFETERIA 
#ROOM 6: LABO DE QUIMICA 
var door_blocked_notification =  preload("res://Ange/door_blocked_notification.tscn")
@export_enum("ROOM-4", "ROOM-5", "ROOM-6", "ROOM-PASILLO1","ROOM-LABOFISICA","ROOM-ENTRADA","ROOM-PASILLO2","ROOM-SALACOMUN","ROOM-CENTROALUMNOS","VACIO")
var room_id: String = "VACIO"
@onready var door_sound_open: AudioStreamPlayer = $door_sound_open
@onready var door_sound_blocked: AudioStreamPlayer = $door_sound_blocked



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
	if room_id != "VACIO" :
		door_sound_open.play()
		await door_sound_open.finished
		interacted.emit(self)
	else:
		door_sound_blocked.play()
		NotificationManager.enqueue_event(door_blocked_notification)

func get_type():
	return my_type
