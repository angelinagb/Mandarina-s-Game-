class_name Interactable extends Node2D

signal interacted(interactable: Interactable)

@export var id: String
@export var texture: Texture

var my_type: String

func _ready():
	$Sprite2D.texture = texture
	$Area2D.set_monitoring(false)
	hide()
	
func getId(): return id

func start():
	$Area2D.set_monitoring(true)
	show()

func end(): self.queue_free()
