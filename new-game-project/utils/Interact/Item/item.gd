class_name Item extends Interactable

@export var texture: Texture

var interaction : Callable
@onready var can_grab: Label = $Can_grab

func _ready():
	can_grab.visible = false
	my_type = "item"
	super._ready()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "PlayerB":
		can_grab.visible = true
		if Input.is_action_just_pressed("ui_accept"):
			interacted.emit(self)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "PlayerB":
		can_grab.visible = false
