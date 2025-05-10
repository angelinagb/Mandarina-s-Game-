extends Node

var world_path: String = "res://world/world.tscn"

func _on_start_menu_world_related_button_pressed(type_world: String) -> void:
	match type_world:
		"NEW_GAME":
			var world = load(world_path).instantiate()
			add_child(world)
			world.new_game()
			$StartMenu.queue_free()
		"RESUME_GAME":
			var world = load(world_path).instantiate()
			add_child(world)
			world.resume_game()
			$StartMenu.queue_free()
		"DELETE_GAME":
			var world = load(world_path).instantiate()
			add_child(world)
			world.delete_game()
			world.queue_free()
