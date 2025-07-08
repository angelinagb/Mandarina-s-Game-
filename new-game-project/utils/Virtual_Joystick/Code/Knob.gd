extends Sprite2D

signal change_motion()
@onready var parent = $".."

@export var maxLength = 50
var deadzone = 15
var pressing := false

func _ready():
	deadzone = parent.deadzone
	maxLength *= parent.scale.x
	set_process_input(true)

func _input(event):
	if event is InputEventScreenTouch:
		if not event.pressed:
			pressing = false
	elif event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			pressing = event.pressed and get_rect().has_point(to_local(event.position))

func _process(delta):
	if pressing:
		var local_pos = parent.to_local(get_global_mouse_position())

		if local_pos.length() <= maxLength:
			position = local_pos
		else:
			position = local_pos.normalized() * maxLength

		calculateVector()
	else:
		position = position.lerp(Vector2.ZERO, delta * 50)
		parent.posVector = Vector2.ZERO

func calculateVector():
	parent.posVector.x = position.x / maxLength if abs(position.x) >= deadzone else 0 
	parent.posVector.y = position.y / maxLength if abs(position.y) >= deadzone else 0 
	
func _on_button_button_down():
	pressing = true

func _on_button_button_up():
	pressing = false
