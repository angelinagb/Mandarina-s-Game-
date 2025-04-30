extends Node
# este codigo actualiza el estado con el delta, quiza sea mejor hacerlo con eventos
##la ref al player 
@export var inital_state : State
@onready var player : Player = self.owner
var current_state : State
var states: Dictionary = {}

#enum STATE{ 
#	IDLE,
#	RUNNING,
#	PUSHING 
#}

func _ready(): 
	for child in get_children():
			if child is State:
				states[child.name.to_lower()] = child
				child.Transitioned.connect(on_child_transition)

func _process(delta: float) -> void:
		if current_state: 
				current_state.Update(delta)

func _physics_process(delta: float) -> void:
		if current_state:
			current_state.Physics_update(delta)

func on_child_transition (state,new_state_name):
	if state != current_state: #algo raro paso
		return 
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state: 
		current_state.exit()
	new_state.enter()
	
	current_state = new_state
	

		 
#func _physics_process(delta: float) -> void:
#	match current_state:
#		STATE.IDLE:
#			player.play_animation(player.animations.idle)
#			player.velocity = Vector2.ZERO
#			
#		STATE.RUNNING:
#			player.play_animation(player.animations.run)
#		STATE.PUSHING:
#			player.play_animation(player.animations.push)
#			player.velocity *=1/4
#	move_and_slide()
