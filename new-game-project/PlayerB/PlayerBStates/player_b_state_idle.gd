#idle
extends PlayerBStateBase

func start():
	pass #le podes poner cualquier maravilla al incio del estado , que cante 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_physics_process(_delta: float) -> void:
	playerb.velocity = Vector2.ZERO
	playerb.update_animation_parameters(playerb.get_facing_direction(), "idle")
	playerb.move_and_slide()
	
func on_input(_event):
	if Input.is_action_pressed("keys"):
		if Input.is_action_pressed("shift") : # tambien cambiar esto a lo que armemos mobile
			state_machine.change_to(playerb.states.Run)
		else: 
			state_machine.change_to(playerb.states.Walk)
	

func end():
	pass
	# liberar todas las maravillas 
