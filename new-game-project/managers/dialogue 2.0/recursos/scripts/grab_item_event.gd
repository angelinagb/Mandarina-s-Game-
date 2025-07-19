extends Evento
class_name Evento_Grab_Item

@export var item_id :String


func trigger():
	NotificationManager.enqueue_event(preload("res://visuals/Notificacion GUI/Instancias/item_picked_up_notif.tscn"))

func _ready():
	type_of_event = "give_item"
	super._ready()
