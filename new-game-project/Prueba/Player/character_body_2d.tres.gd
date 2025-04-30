class_name Player
extends CharacterBody2D

@export var SPEED = 300.0

var last_direction = Vector2(0, 1) 
@onready var sprite = $AnimatedSprite2D
@onready var this = $"."
#@onready var animations

const ISO_TRANSFORM = Transform2D( 
	Vector2(0.707, -0.407),  # dirección X en isométrico (derecha)
	Vector2(0.707, 0.407),   # dirección Y en isométrico (abajo)
	Vector2.ZERO
)

func _physics_process(delta: float) -> void:
	var dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if dir != Vector2.ZERO:
		dir = dir.normalized()
		last_direction = dir  # Guarda la última dirección válida
	
	var iso_dir = ISO_TRANSFORM * dir
	velocity = iso_dir * SPEED
	move_and_slide()
