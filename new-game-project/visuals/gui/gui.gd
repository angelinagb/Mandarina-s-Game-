extends CanvasLayer
class_name GUI

signal button_open_menu_pressed

func _on_button_pressed() -> void:
	button_open_menu_pressed.emit()

	#control.mouse_filter = Control.MOUSE_FILTER_IGNORE
