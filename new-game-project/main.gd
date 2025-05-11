extends Node

var world_path: String = "res://world/world.tscn"
var world = null

func open_start_menu():
	$StartMenu.show()
	$StartMenu.process_mode = Node.PROCESS_MODE_ALWAYS
	if world != null:
		world.queue_free()

func close_start_menu():
	$StartMenu.hide()
	$StartMenu.process_mode = Node.PROCESS_MODE_DISABLED

func _ready():
	open_start_menu()

func _on_start_menu_button_pressed(type_world: String) -> void:
	match type_world:
		"NEW_GAME":
			world = load(world_path).instantiate()
			add_child(world)
			world.new_game()
			world.add_main(self)
			close_start_menu()
		"RESUME_GAME":
			world = load(world_path).instantiate()
			add_child(world)
			world.resume_game()
			world.add_main(self)
			close_start_menu()
		"DELETE_GAME":
			world = load(world_path).instantiate()
			add_child(world)
			world.delete_game()
			world.queue_free()
		"CLOSE_APP":
			get_tree().quit()
