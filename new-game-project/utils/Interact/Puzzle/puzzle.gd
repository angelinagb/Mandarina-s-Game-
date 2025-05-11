class_name Puzzle_Activator
extends Interactable

@export var path_scene: String
@export var item: String

func _ready():
	my_type = "puzzle_activator"
	super._ready()
