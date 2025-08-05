class_name Item extends Interactable

@export var texture: Texture

var interaction : Callable
var is_in_area : bool
var taken := false

func _ready():
	my_type = "item"
	super._ready()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "PlayerB" and not taken:
		InteractionManager.set_interactuable(self)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "PlayerB":
		InteractionManager.clear_interactuable(self)


func interact():
		interacted.emit(self)
		taken = true
		process_mode = Node.PROCESS_MODE_DISABLED
		visible = false
		
func get_type()  -> String :
	return my_type

func get_state() -> Dictionary:
	var state = {}
	state["taken"] = taken
	state["process_mode"] = process_mode
	state["visible"] = not taken
	return state
	
func load_state(current_state):
	taken = current_state["taken"]
	process_mode = current_state["process_mode"]
	self.visible = current_state["visible"]
