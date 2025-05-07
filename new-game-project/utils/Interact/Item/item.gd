class_name Item
extends Interactable

func _ready():
	my_type = "item"
	super._ready()

func _on_area_2d_body_entered(body: Node2D) -> void:
	interacted.emit(self)
