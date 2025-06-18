extends Control
@onready var menu_music: AudioStreamPlayer = $MenuMusic
@onready var sfx_music: AudioStreamPlayer = $"SFX Music"

signal world_related_button_pressed(type_world: String)

func _on_new_game_pressed() -> void:
	sfx_music.play()
	await sfx_music.finished
	world_related_button_pressed.emit("NEW_GAME")
	

func _on_resume_game_pressed() -> void:
	sfx_music.play()
	await sfx_music.finished
	world_related_button_pressed.emit("RESUME_GAME")


func _on_delete_game_pressed() -> void:
	world_related_button_pressed.emit("DELETE_GAME")

func _ready() -> void:
	menu_music.play()
	
