extends PlayerBStateBase

#trasnformacion isometrica
const ISO_TRANSFORM = Transform2D( 
	Vector2(0.707, -0.407),  # dirección X en isométrico (derecha)
	Vector2(0.707, 0.407),   # dirección Y en isométrico (abajo)
	Vector2.ZERO
)

#se llama en cada frame si el vel != 0 
func on_physics_process(_delta):
	var dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") 
	dir = dir.normalized()  
	playerb.update_facing_direction(dir) # guardar la última dirección válida
	var iso_dir = ISO_TRANSFORM * dir
	playerb.move_and_slide()
	playerb.velocity  = iso_dir * playerb.SPEED
	playerb.update_animation_parameters(dir,"walk")
	

func on_input(_event):
	if not Input.is_action_pressed("keys") :
		state_machine.change_to(playerb.states.Idle)
	if Input.is_action_just_pressed("shift"):
		state_machine.change_to(playerb.states.Run)
		
