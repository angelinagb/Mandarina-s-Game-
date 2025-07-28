extends Evento
class_name Evento_Grab_Item

@export var item_id :String


func trigger():
	pass
	
func _ready():
	type_of_event = "give_item"
	super._ready()
