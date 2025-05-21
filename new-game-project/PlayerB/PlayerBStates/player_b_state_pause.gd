extends PlayerBStateBase

func start():
	playerb.update_animation_parameters(playerb.get_facing_direction(),"idle")

func on_physics_process(delta):	
	playerb.velocity = Vector2.ZERO
	controlled_node.move_and_slide()
