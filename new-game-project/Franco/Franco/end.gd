extends CanvasLayer

@onready var dialogo_sistema : DialogueSystem = $"Dialogue System"

func start():
	await get_tree().create_timer(3.0).timeout
	get_tree().quit()
