class_name Player
extends CharacterBody2D

@export var movement_stats: MovementStats = MovementStats.new()

@onready var animation_player = $AnimatedSprite2D

var states:PlayerStateNames = PlayerStateNames.new()
var animations:PlayerAnimations = PlayerAnimations.new()

func _ready():
	z_index = 1
	
func play_animation(animation_name:String):
	animation_player.play(animation_name)

func move_to(spawn_position: Vector2):
	position = spawn_position

func pause_player():
	$StateMachine.change_to(states.Paused)

func resume_player():
	$StateMachine.change_to(states.Idle)
	
