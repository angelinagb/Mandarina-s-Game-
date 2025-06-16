class_name PlayerB extends CharacterBody2D
#Cambiar nombre de las animaciones
#actualizar grados de la direccion para abarcar las 8 direcciones 



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
func update_animation_parameters(dir: Vector2, state: String) -> void:
	var anim = ""
	var angle = dir.angle()
		# Convierto la dirección en 8 sectores
	if angle >= -PI / 4 and angle < PI / 4:
		anim = "_north"
	elif angle >= PI / 4 and angle < 3 * PI / 4:
		anim = "_east"
	elif angle >= -3 * PI / 4 and angle < -PI / 4:
		anim = "_west"
	else:
		anim = "_south"

	# Ahora actualizás la animación del player
	sprite.play(state + anim)

func get_facing_direction() -> Vector2 : 
	return facing_direction
	
func update_facing_direction(new_dir : Vector2) -> void : 
	facing_direction = new_dir
	
func esconder_joystick():
	#agregado para cinematicas
	joystick.hide()
	
func mostrar_joystick():
	#agregado para cinematicas
	joystick.show()
