extends PlayerStateBase

func start():
	player.play_animation(player.animations.idle)

func on_physics_process(delta):	
	player.velocity = Vector2.ZERO
	controlled_node.move_and_slide()
	
func on_input(_event):
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_up"): 
		state_machine.change_to(player.states.UpRight)
	elif Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_down"): 
		state_machine.change_to(player.states.DownRight)
	elif Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_up"): 
		state_machine.change_to(player.states.UpLeft)
	elif Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_down"): 
		state_machine.change_to(player.states.DownLeft)
	elif Input.is_action_pressed("ui_right"):  
		state_machine.change_to(player.states.Right)
	elif Input.is_action_pressed("ui_left"):  
		state_machine.change_to(player.states.Left)
	elif Input.is_action_pressed("ui_up"):  
		state_machine.change_to(player.states.Up)
	elif Input.is_action_pressed("ui_down"):  
		state_machine.change_to(player.states.Down)
