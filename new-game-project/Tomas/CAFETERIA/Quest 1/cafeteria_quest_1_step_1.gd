extends QuestStep

@export var minijuego : PackedScene
@export var dialogo_final : PackedScene
@export var quest_completada : PackedScene

func on_completed():
	QueueManager.enqueue_event(minijuego)
	await QueueManager.finished
	QueueManager.enqueue_event(dialogo_final)
	await QueueManager.finished
	QueueManager.enqueue_event(quest_completada)
	await QueueManager.finished
