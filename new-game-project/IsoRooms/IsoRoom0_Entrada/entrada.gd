extends IsoRoom

signal quest_begun
@export var initial_quest: Quest

func _ready() -> void:
	super._ready()
	intro()
	

func intro():
	QuestManager.add_quest(initial_quest)
	
func outro():
	pass

func on_quest_ended():
	pass
