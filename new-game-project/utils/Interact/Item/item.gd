class_name Item extends Interactable

@export var texture: Texture
@export var item_notification : PackedScene

var interaction : Callable
var is_in_area : bool

func _ready():
	my_type = "item"
	super._ready()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "PlayerB":
		print("hola querido soy un " + my_type+ " " + id)
		InteractionManager.set_interactuable(self)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "PlayerB":
		InteractionManager.clear_interactuable(self)


func interact():
		print("item")
		interacted.emit(self)
		NotificationManager.enqueue_event(item_notification)
		
func get_type()  -> String :
	return my_type
