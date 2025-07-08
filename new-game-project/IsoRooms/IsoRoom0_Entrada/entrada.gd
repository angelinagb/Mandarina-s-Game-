extends IsoRoom

signal quest_begun
@export var initial_quest: Quest

func _ready() -> void:
	super._ready()
	intro()
	

func intro():
	pass 
func outro():
	pass
