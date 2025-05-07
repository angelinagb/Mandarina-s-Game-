extends Control

signal world_related_button_pressed(type_world: String)

func _on_new_game_pressed() -> void:
	world_related_button_pressed.emit("NEW_GAME")


func _on_resume_game_pressed() -> void:
	world_related_button_pressed.emit("RESUME_GAME")


func _on_delete_game_pressed() -> void:
	world_related_button_pressed.emit("DELETE_GAME")
