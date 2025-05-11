class_name NpcQuestGiver extends Npc

@export var quest: Quest
@export var dialogues: Array[String]
@export var necessary_events: Array[String]

enum STATES{
	QUEST_GIVE,
	QUEST_WAIT,
	QUEST_COMPLETE,
	END_INTERACTION
}

var actual_state: STATES

func _ready():
	super._ready()

func define_state(event_list: Array[String]) -> void:
	if(not event_list.has("FrancoQuestGiven")):
		actual_state =STATES.QUEST_GIVE
	elif (event_list.has("FrancoQuestCompleted")):
		actual_state = STATES.END_INTERACTION
	elif (not event_list.has("Termo") or not event_list.has("Yerba") or not event_list.has("Mate")):
		actual_state = STATES.QUEST_WAIT
	elif (event_list.has("Termo") and event_list.has("Yerba") and event_list.has("Mate")):
		actual_state = STATES.QUEST_COMPLETE

func get_actual_state():
	return actual_state

func get_quest() -> Quest:
	return quest

func get_dialogues():
	return dialogues
