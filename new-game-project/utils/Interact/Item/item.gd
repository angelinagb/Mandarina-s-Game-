class_name Item extends Interactable

@export var texture: Texture
@export var item_notification : PackedScene

var interaction : Callable
var is_in_area : bool
@onready var can_grab: Label = $Can_grab

func _ready():
	can_grab.visible = false
	my_type = "item"
	super._ready()


func _on_area_2d_body_entered(body: PlayerB) -> void:
	is_in_area = true
	if body.name == "PlayerB":
		can_grab.visible = true


func _on_area_2d_body_exited(body: PlayerB) -> void:
	is_in_area = false
	if body.name == "PlayerB":
		can_grab.visible = false

func _process(delta: float) -> void:
	if is_in_area and Input.is_action_just_pressed("ui_accept"):
		interacted.emit(self)
		NotificationManager.enqueue_event(item_notification)
