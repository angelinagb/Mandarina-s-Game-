class_name PlayerB extends CharacterBody2D

@export var SPEED = 300.0

@onready var sprite = $AnimatedSprite2D
@onready var this = $"."
@onready var state_machine = $StateMachine
@onready var joystick: Node2D = $Joystick


var facing_direction = Vector2(0, 1) 
var states: PlayerBStateNames = PlayerBStateNames.new()

#region

func initialize(initial_position: Vector2):
	self.position = initial_position

func move_to(spawn_position: Vector2):
	position = spawn_position

func pause_player():
	$StateMachine.change_to(states.Paused)

func resume_player():
	$StateMachine.change_to(states.Idle)

#endregion 

#seria lo equiv a play_animation
func update_animation_parameters(dir: Vector2, state: String):
	var anim = "_west"
	if dir.x == 0 and dir.y == -1:
		anim = "_west" #315
	elif dir.x == 0 and dir.y == 1:
		anim = "_east"#143
	elif dir.x == -1 and dir.y == 0:
		anim = "_south" #247
	elif dir.x == 1 and dir.y == 0:
		anim = "_north" #67

	sprite.play(state + anim)

func get_facing_direction() -> Vector2 : 
	return facing_direction
	
func update_facing_direction(new_dir : Vector2) -> void : 
	facing_direction = new_dir
