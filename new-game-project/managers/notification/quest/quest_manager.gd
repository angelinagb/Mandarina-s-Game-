class_name QuestManager
extends Node



signal new_active_secondary_quest(quest: Quest)
signal quest_updated(quest: Quest)
signal all_level_quest_completed

var taken_quests: Array[Quest] = []
var completed_quest: Array[Quest] = []
var active_primary_quest : Quest = null
var active_secondary_quest : Quest = null
var event_manager: EventManager
@onready var titulo_main : Label = $"CanvasLayer/Quests Info/PanelContainer/MarginContainer/Active Main Quest/Titulo"
@onready var step_main : Label= $"CanvasLayer/Quests Info/PanelContainer/MarginContainer/Active Main Quest/Step"
@onready var titulo_secondary : Label= $"CanvasLayer/Quests Info/PanelContainer2/MarginContainer/Active Secondary Quest/Titulo"
@onready var step_secondary : Label = $"CanvasLayer/Quests Info/PanelContainer2/MarginContainer/Active Secondary Quest/Quest"
@onready var ui_main : PanelContainer = $"CanvasLayer/Quests Info/PanelContainer"
@onready var ui_secondary : PanelContainer = $"CanvasLayer/Quests Info/PanelContainer2"
@onready var quests_info: VBoxContainer = $"CanvasLayer/Quests Info"


func set_main(titulo : String, step : String):
	titulo_main.text = titulo
	step_main.text = step
	if(titulo == "" and step == ""):
		ui_main.hide()
	else:
		ui_main.show()
	
func set_secondary(titulo : String, step : String):
	titulo_secondary.text = titulo
	step_secondary.text = step
	if(titulo == "" and step == ""):
		ui_secondary.hide()
	else:
		ui_secondary.show()

@warning_ignore("shadowed_variable")
func initialize(event_manager: EventManager, taken_quests: Array[Quest]):
	self.event_manager = event_manager
	event_manager.event_added.connect(on_event_added)
	
	self.taken_quests = taken_quests
	
func on_quest_finished(title):
	var ended_quest = get_quest_by_title(title)
	if ended_quest == null:
		print("⚠️ Quest con título '%s' no encontrada o ya completada." % title)
		return
	
	var quest_completed_scene = preload("res://Tomas/pop up/quest_completed.tscn")
	var temp = quest_completed_scene.instantiate()
	var personalizada = temp.get_personalized_scene(title)
	NotificationManager.enqueue_event(personalizada)	
	
	completed_quest.append(ended_quest)
	taken_quests.erase(ended_quest)
	
	var next: Quest
	if taken_quests.size() > 0 &&  taken_quests[0] != null :
		if ended_quest.is_secondary == true :
			next = get_next_Secondary()
			if next:
				set_secondary(next.title,next.get_current_step().text_to_do)
			else:
				set_secondary("","")
		else: 
			next = get_next_primary()
			if next:
				set_main(next.title,next.get_current_step().text_to_do)
			else:
				set_main("","")
	
func add_quest(quest: Quest) -> void:
	if  get_quest_by_title(quest.title) == null:
		NotificationManager.enqueue_event(preload("res://new_quest_notification.tscn"))
		quest.quest_ended.connect(on_quest_finished)
		taken_quests.append(quest)
		if quest.is_secondary and active_secondary_quest == null:
			active_secondary_quest = quest
			set_secondary(quest.title, quest.get_current_step().text_to_do)
			new_active_secondary_quest.emit(quest)
		else:
			if !quest.is_secondary and active_primary_quest == null:
				active_primary_quest = quest
			set_main(quest.title, quest.get_current_step().text_to_do)
		quest_updated.emit(quest)
		$CanvasLayer/CheckButton.visible = true
		
func on_event_added(event: String) -> void:
	for quest in taken_quests:
		if not quest.is_completed():
			var edited: bool = quest.register_interactable(event)
			if edited:
				quest_updated.emit(quest)
				if quest.is_completed():
					quest.quest_ended.emit(quest.title)
			
	

#solo en takern quest claro
func get_quest_by_title(title: String) -> Quest:
	for quest in taken_quests:
		if quest.title == title:
			return quest
	return null

func get_active_quests() -> Array[Quest]:
	return taken_quests.filter(func(q): return not q.is_completed())


func _on_menu_secondary_quest_picked(title: String) -> void:
	var picked_quest : Quest = get_quest_by_title(title)
	if picked_quest != active_secondary_quest:
		active_secondary_quest = picked_quest
		set_secondary(picked_quest.title, picked_quest.get_current_step().text_to_do)
		quest_updated.emit(picked_quest)
		
func finished_level():
	all_level_quest_completed.emit()
	


func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on == true :
		quests_info.visible = true
	else :
		quests_info.visible = false

func update_quest(quest: Quest) -> void:
	# Si la quest es la principal activa, actualizamos su UI
	if quest == active_primary_quest:
		set_main(quest.title, quest.get_current_step().text_to_do)

	# Si es la secundaria activa, actualizamos su UI también
	elif quest == active_secondary_quest:
		set_secondary(quest.title, quest.get_current_step().text_to_do)


func get_next_primary() -> Quest :
	var i := 0 
	var size = taken_quests.size()
	if size == 0 :
		return null
	else:
		var actual = taken_quests[0]
		while i < size and actual.is_secondary == true:
			i+=1
		if i == size :
			return null
		else: 
			return actual
		
func get_next_Secondary() -> Quest :
	var i := 0 
	var size = taken_quests.size()
	if size == 0 :
		return null
	else:
		var actual = taken_quests[0]
		while i < size and actual.is_secondary == false:
			i+=1
		if i == size :
			return null
		else: 
			return actual
