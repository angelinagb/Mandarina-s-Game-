extends Evento
class_name Event_Enqueue_Event
#no rename para no romper lo que ya esta hecho cuando resetee, pero lo ideal seria enque_puzzle

@export var event: PackedScene #puzzle
@export var dialogo_lose: Dialogo
@export var dialogo_win: Dialogo

var parent : Node

func trigger():
	if event.instantiate() is not Puzzle:
		QueueManager.enqueue_event(event)
		await QueueManager.finished
