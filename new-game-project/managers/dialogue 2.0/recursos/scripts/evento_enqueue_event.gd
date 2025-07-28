extends Evento
class_name Event_Enqueue_Event

@export var event: PackedScene #puzzle

func trigger():
	QueueManager.enqueue_event(event)
	await QueueManager.finished
