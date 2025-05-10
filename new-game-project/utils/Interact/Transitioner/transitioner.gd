class_name Transitioner extends Interactable

@export var path_scene: String

func _ready():
	my_type = "transitioner"
	super._ready()

func start():
	await get_tree().create_timer(1).timeout
	super.start()

func get_path_room():
	return path_scene
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	interacted.emit(self)
