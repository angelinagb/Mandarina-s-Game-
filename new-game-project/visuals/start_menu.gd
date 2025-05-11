extends Control

signal button_pressed(type_world: String)

func _ready():
	pass

func _on_new_game_pressed() -> void:
	button_pressed.emit("NEW_GAME")

func _on_resume_game_pressed() -> void:
	button_pressed.emit("RESUME_GAME")

func _on_delete_game_pressed() -> void:
	button_pressed.emit("DELETE_GAME")

func _on_close_app_pressed() -> void:
	button_pressed.emit("CLOSE_APP")
