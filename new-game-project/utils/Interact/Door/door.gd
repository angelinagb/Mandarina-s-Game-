class_name Door extends Interactable

@export var new_room_path: String

@export var necessary_item_id: String

@export var notification_text: String

@export var path_sprite_open: String

@export var path_sprite_close: String


var actual_state: STATES

enum STATES {
	OPEN,
	CLOSE
}

func _ready():
	my_type = "door"
	super._ready()

func get_necessary_item_id():
	return necessary_item_id
	
func get_new_room_path():
	return new_room_path

func get_notification():
	return notification_text

func is_open():
	return actual_state == STATES.OPEN

func open_door():
	actual_state = STATES.OPEN
	$Sprite2D.texture = load(path_sprite_open)

func close_door():
	actual_state = STATES.CLOSE
	$Sprite2D.texture = load(path_sprite_close)
