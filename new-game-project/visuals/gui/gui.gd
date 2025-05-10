extends CanvasLayer

signal button_open_menu_pressed

func _on_button_pressed() -> void:
	button_open_menu_pressed.emit()
