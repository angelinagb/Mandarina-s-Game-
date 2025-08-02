extends Activator

const BLOCKED_BY_IA = preload("res://Ange/blocked_by_ia.tscn")
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	activable = BLOCKED_BY_IA.instantiate().get_personalized_scene("personalized", "⚠ Solo entrega yerba a usuarios con nivel de productividad satisfactorio ( Intelecto nivel: 3)")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func interact():
	NotificationManager.enqueue_event(activable)
	interacted.emit(self)
	end_activable.emit()
	
