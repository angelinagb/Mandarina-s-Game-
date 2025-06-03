extends CanvasLayer

signal button_open_menu_pressed
@onready var control: Control = $Control

func _on_button_pressed() -> void:
	button_open_menu_pressed.emit()

#func showbehind():
	#control.mouse_filter = Control.MOUSE_FILTER_IGNORE
