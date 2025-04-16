class_name Item
extends Node2D

signal grabbed

@export var id: int
@export var sprite_frame: int

func _ready():
	$Sprite2D.set_frame(sprite_frame)

func delete():
	self.queue_free()
		
func getId():
	return id

func _on_area_2d_body_entered(body: Node2D) -> void:
	grabbed.emit()
