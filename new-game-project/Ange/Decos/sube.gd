extends CanvasLayer

signal finished

func _on_button_pressed() -> void:
	finished.emit()
	queue_free()
	
func start():
	process_mode = Node.PROCESS_MODE_ALWAYS
