class_name Npc extends Interactable

func _ready():
	my_type = "npc"
	super._ready()

func get_quest() -> Quest:
	return null

func get_dialogue():
	return null
