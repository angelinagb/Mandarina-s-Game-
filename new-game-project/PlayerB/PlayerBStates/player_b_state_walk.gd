extends PlayerBStateBase

# Transformación isométrica -> NLN
#const ISO_TRANSFORM = Transform2D( 
	#Vector2(0.707, -0.407),  # dirección X en isométrico (derecha)
	#Vector2(0.707, 0.407),   # dirección Y en isométrico (abajo)
	#Vector2.ZERO
#)

func start():
	playerb.start_audio()

func on_physics_process(_delta):
	# Obtener el vector normalizado del joystick
	var raw_input = playerb.joystick.posVector

	# Reinterpretar como vector direccional puro (imitando Input.get_vector)
	var dir := Vector2.ZERO
	if raw_input.x > 0.1:
		dir.x = 1
	elif raw_input.x < -0.1:
		dir.x = -1

	if raw_input.y > 0.1:
		dir.y = 1
	elif raw_input.y < -0.1:
		dir.y = -1

	dir = dir.normalized()

	# Si no hay input, pasar a Idle
	if dir.length() == 0:
		state_machine.change_to(playerb.states.Idle)
		return

	# Actualizar dirección 
	playerb.update_facing_direction(dir)

	#var iso_dir = ISO_TRANSFORM * dir
	playerb.velocity = dir * playerb.SPEED
		
	playerb.update_animation_parameters(dir, "walk")
	playerb.move_and_slide()
	
func end():
	playerb.stop_audio()
