extends Evento
class_name Evento_Grab_Item

@export var item_id : String
signal new_item(item_id : String)

func trigger():
	NotificationManager.enqueue_event(preload("res://visuals/Notificacion GUI/Instancias/item_picked_up_notif.tscn"))
	new_item.emit(item_id)
