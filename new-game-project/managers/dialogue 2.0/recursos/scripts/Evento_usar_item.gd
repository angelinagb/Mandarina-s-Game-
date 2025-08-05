extends Evento
class_name event_use_item

@export var item_id: String

func trigger():
	pass
	
func _ready():
	type_of_event = "use_item"
	super._ready()
