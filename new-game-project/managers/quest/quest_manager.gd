class_name QuestManager
extends Node

var active_quests: Array[Quest] = []
var event_manager: EventManager

signal quest_updated(quest: Quest)

func initialize(event_manager: EventManager, active_quests: Array[Quest]):
	self.event_manager = event_manager
	event_manager.event_added.connect(on_event_added)
	
	self.active_quests = active_quests
	
	
func add_quest(quest: Quest) -> void:
	if not active_quests.has(quest):
		active_quests.append(quest)
		for event in event_manager.getEvents():
			quest.register_interactable(event)
		quest_updated.emit(quest)

func on_event_added(event: String) -> void:
	for quest in active_quests:
		if not quest.is_completed():
			var edited: bool = quest.register_interactable(event)
			if edited:
				quest_updated.emit(quest)

func get_quest_by_title(title: String) -> Quest:
	for quest in active_quests:
		if quest.title == title:
			return quest
	return null

func get_active_quests() -> Array[Quest]:
	return active_quests.filter(func(q): return not q.is_completed())
