extends Node

#Es como QueueManager, solo que este no bloquea gameplay
#Es decir no pausea el arbol sino que sucede asincronicamente
#En un thread aparte se muestran secuencialmente los elementos de la cola de eventos
#Igual que QueueManager, las escenas tienen que usar la señal finished

var async_queue = []
var is_playing = false

signal finished


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func enqueue_event(async_scene: PackedScene):
	async_queue.append(async_scene)
	if not is_playing:
		_start_queue()
	else:
		await QueueManager.finished
func _start_queue():
	is_playing = true
	#no pausea arbol, ya que es asincronica la notificacion
	_process_queue()

func _process_queue() -> void:
	if async_queue.is_empty():
		is_playing = false
		finished.emit()
		return
	var scene = async_queue.pop_front()
	var event_instance = scene.instantiate()
	get_tree().root.add_child(event_instance)
	event_instance.start()
	await event_instance.finished  # Custom signal when the event is done
	event_instance.queue_free()
	_process_queue()
 
