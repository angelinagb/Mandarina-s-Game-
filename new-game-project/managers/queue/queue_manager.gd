extends Node

var event_queue = []
var is_playing = false

signal finished


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func enqueue_event(event_scene: PackedScene):
	event_queue.append(event_scene)
	if not is_playing:
		_start_queue()
		
func _start_queue():
	is_playing = true
	get_tree().paused = true
	_process_queue()

func _process_queue() -> void:
	if event_queue.is_empty():
		is_playing = false
		get_tree().paused = false
		finished.emit()
		return

	var scene = event_queue.pop_front()
	var event_instance = scene.instantiate()
	get_tree().root.add_child(event_instance)
	event_instance.start()
	await event_instance.finished  # Custom signal when the event is done
	event_instance.queue_free()
	_process_queue()
	
	
func enqueue_instance(event_instance: Node):
	add_child(event_instance)
