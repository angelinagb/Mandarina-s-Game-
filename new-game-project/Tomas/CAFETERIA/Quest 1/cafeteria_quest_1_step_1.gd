extends QuestStep

@export var minijuego : PackedScene
@export var dialogo_final : PackedScene

func on_completed():
	QueueManager.enqueue_event(minijuego)
	await QueueManager.finished
	QueueManager.enqueue_event(dialogo_final)
