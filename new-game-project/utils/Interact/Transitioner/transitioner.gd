class_name Transitioner extends Interactable
#ROOM 4: AULA 01
#ROOM 5: CAFETERIA 
#ROOM 6: LABO DE QUIMICA 
@export_enum("ROOM-4", "ROOM-5", "ROOM-6", "ROOM-PASILLO1","ROOM-LABOFISICA","ROOM-ENTRADA","ROOM-PASILLO2","ROOM-SALACOMUN","ROOM-CENTROALUMNOS")
var room_id: String
@onready var door_sound: AudioStreamPlayer = $door_sound

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
		print("rtas")
		InteractionManager.clear_interactuable(self)


func interact() :
	door_sound.play()
	await door_sound.finished
	interacted.emit(self)

func get_type():
	return my_type
