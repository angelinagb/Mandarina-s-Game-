class_name Transitioner extends Interactable

@export_enum("ROOM-4", "ROOM-5", "ROOM-6")
var room_id: String

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
	interacted.emit(self)

func get_type():
	return my_type
