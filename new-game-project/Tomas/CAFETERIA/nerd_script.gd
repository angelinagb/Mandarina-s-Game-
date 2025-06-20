extends Npc

@export var puzzle : PackedScene
@export var dialogo_victoria : PackedScene

func interact():
	super.interact()
	QueueManager.enqueue_event(puzzle)
	await QueueManager.finished
	QueueManager.enqueue_event(dialogo_victoria)
	await QueueManager.finished
	
	
