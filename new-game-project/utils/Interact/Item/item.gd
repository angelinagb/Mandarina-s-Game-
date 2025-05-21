class_name Item extends Interactable

@export var texture: Texture

var interaction : Callable

func _ready():
	Sprite2D.texture = texture
	my_type = "item"
	super._ready()

func _on_area_2d_body_entered(body: Node2D) -> void:
	interacted.emit(self)
