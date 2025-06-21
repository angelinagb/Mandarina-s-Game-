extends Npc

@export var puzzle : PackedScene
@export var dialogo_victoria : PackedScene
@export var quest_completada : PackedScene

func interact():
	await super.interact()
	QueueManager.enqueue_event(puzzle)
	await QueueManager.finished
	QueueManager.enqueue_event(dialogo_victoria)
	await QueueManager.finished
	QueueManager.enqueue_event(quest_completada)
	await QueueManager.finished
	process_mode = Node.PROCESS_MODE_DISABLED
