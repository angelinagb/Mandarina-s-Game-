class_name Interactable extends Node2D
@warning_ignore("unused_signal")
signal interacted(interactable: Interactable)

#los id pueden ser combinacion room + tipo + orden 
@export var id: String

var my_type: String

func _ready():
	add_to_group("Con Estado")
	
func getId(): return id

func load_state(loaded_state : Dictionary):
	visible = loaded_state["visible"]
	#leo de loaded_state el valor de todas las variables que me interesaron guardar en get_state y se las asigno
	
func get_state() -> Dictionary:
	var state = {}
	state["visible"] = visible
	#en cada implementacion de interactuable meto las variables que quiero que se guarden state
	return state

func end():
	hide()

"""override"""
func interactuar():
	pass

@warning_ignore("unused_parameter")
func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.

@warning_ignore("unused_parameter")
func _on_area_2d_body_exited(body: Node2D) -> void:
	pass # Replace with function body.

func get_type()  -> String:
	return my_type
