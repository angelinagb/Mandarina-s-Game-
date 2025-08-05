extends Npc

@export var puzzle : PackedScene
@export var dialogo_victoria : PackedScene # por que no es un dialogo?

func interact():
	await super.interact()
	QueueManager.enqueue_event(puzzle)
	await QueueManager.finished
	QueueManager.enqueue_event(dialogo_victoria)
	await QueueManager.finished	
	NotificationManager.enqueue_event(preload("res://visuals/Notificacion GUI/Instancias/item_picked_up_notif.tscn"))
	#provisorio-> puedo hacer una quest
	process_mode = Node.PROCESS_MODE_DISABLED
