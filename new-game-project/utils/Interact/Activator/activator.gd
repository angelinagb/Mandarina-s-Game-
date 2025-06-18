extends Interactable

@export var activable : PackedScene

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _ready():
	my_type = "activator"
	super._ready()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "PlayerB":
		InteractionManager.set_interactuable(self)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "PlayerB":
		InteractionManager.clear_interactuable(self)


func interact():
		QueueManager.enqueue_event(activable)
		await QueueManager.finished
		interacted.emit(self)
		
func get_type()  -> String :
	return my_type
