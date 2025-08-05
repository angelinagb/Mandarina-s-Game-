extends CanvasLayer
@onready var osicloscopio: Node2D = $Osicloscopio

signal  finished

func start():
	osicloscopio.start()


func _on_osicloscopio_finished() -> void:
	queue_free()
	finished.emit()
