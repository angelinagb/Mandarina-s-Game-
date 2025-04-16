extends PlayerStateBase

func on_physics_process(delta):	
	controlled_node.play_animation(controlled_node.animations.down_right)
	var vel = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)
	vel = vel.normalized()

	controlled_node.velocity = vel * controlled_node.movement_stats.running_speed
	controlled_node.move_and_slide()
	
func on_input(_event):
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_up"): 
		state_machine.change_to(player.states.UpRight)
	elif Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_down"): 
		state_machine.change_to(player.states.DownLeft)
	elif Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_up"): 
		state_machine.change_to(player.states.UpLeft)
	elif Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_down"):  
		state_machine.change_to(player.states.Right)
	elif Input.is_action_pressed("ui_left"):  
		state_machine.change_to(player.states.Left)
	elif Input.is_action_pressed("ui_up"):  
		state_machine.change_to(player.states.Up)
	elif Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_right"):  
		state_machine.change_to(player.states.Down)
	elif not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
		state_machine.change_to(player.states.Idle)
