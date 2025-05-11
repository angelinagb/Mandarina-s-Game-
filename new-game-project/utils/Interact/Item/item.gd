class_name Item
extends Interactable

@export var notification_text: String

func _ready():
	my_type = "item"
	super._ready()

func start():
	
	super.start()

func get_notification():
	return notification_text
