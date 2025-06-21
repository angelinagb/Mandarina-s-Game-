extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

const SPEED = 300.0

func move_north():
	pass

func _ready() -> void:
	animation_player.play("walk_north")
