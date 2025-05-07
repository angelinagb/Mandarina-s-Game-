extends PlayerStateBase

func start():
	player.play_animation(player.animations.idle)

func on_physics_process(delta):	
	player.velocity = Vector2.ZERO
	controlled_node.move_and_slide()
