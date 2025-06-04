extends CanvasLayer

signal replay_pressed()
signal out_pressed()

@onready var replay: Button = $Panel/MarginContainer/VBoxContainer/HBoxContainer/Replay
@onready var out: Button = $Panel/MarginContainer/VBoxContainer/HBoxContainer/Out

func _on_replay_pressed() -> void:
	replay_pressed.emit()
	queue_free()

func _on_out_pressed() -> void:
	out_pressed.emit()
	queue_free()
