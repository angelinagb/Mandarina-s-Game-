class_name Interactable extends Node2D

signal interacted(interactable: Interactable)

@export var id: String
@export var texture: Texture

var player_in_range = false
var my_type: String

func _ready() -> void:
	$Sprite2D.texture = texture
	$Area2D.set_monitoring(false)
	hide()
	
func getId() -> String: return id

func start() -> void:
	$Area2D.set_monitoring(true)
	show()

func end() -> void: self.queue_free()

func interact():
	interacted.emit(self)
	
func _input(event):
	if player_in_range and Input.is_action_just_pressed("ui_accept"):
		interact()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = false
