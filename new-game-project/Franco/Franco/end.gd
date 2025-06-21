extends CanvasLayer

signal game_finished

@onready var dialogo_sistema : DialogueSystem = $"Dialogue System"

func start():
	dialogo_sistema.start()
	await dialogo_sistema.finished
	game_finished.emit()
	
