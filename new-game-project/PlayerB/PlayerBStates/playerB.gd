class_name PlayerB extends CharacterBody2D
#Cambiar nombre de las animaciones
#actualizar grados de la direccion para abarcar las 8 direcciones 
@onready var steps: AudioStreamPlayer = $Steps



@export var SPEED = 250.0

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
func update_animation_parameters(dir: Vector2, state: String) -> void:
	if dir.length() == 0:
		sprite.play(state + "_down")  # default
		return

	var angle = dir.angle()
	var anim = ""

	if angle >= -PI/8 and angle < PI/8:
		anim = "_right"
	elif angle >= PI/8 and angle < 3*PI/8:
		anim = "_down_right"
	elif angle >= 3*PI/8 and angle < 5*PI/8:
		anim = "_down"
	elif angle >= 5*PI/8 and angle < 7*PI/8:
		anim = "_down_left"
	elif angle >= 7*PI/8 or angle < -7*PI/8:
		anim = "_left"
	elif angle >= -7*PI/8 and angle < -5*PI/8:
		anim = "_up_left"
	elif angle >= -5*PI/8 and angle < -3*PI/8:
		anim = "_up"
	elif angle >= -3*PI/8 and angle < -PI/8:
		anim = "_up_right"

	sprite.play(state + anim)

func get_facing_direction() -> Vector2 : 
	return facing_direction
	
func update_facing_direction(new_dir: Vector2) -> void:
	if new_dir.length() > 0.1:
		facing_direction = new_dir.normalized()
	
func esconder_joystick():
	#agregado para cinematicas
	joystick.hide()
	
func mostrar_joystick():
	#agregado para cinematicas
	joystick.show()

func start_audio():
	steps.play()
	
func stop_audio():
	steps.stop()
