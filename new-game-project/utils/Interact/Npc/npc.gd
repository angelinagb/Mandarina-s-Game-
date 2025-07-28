class_name Npc extends Interactable

signal quest_begun
signal dialogue_ended
signal quest_ended(title)
signal item_used(item_id: String)

@export var gives_item: String
@export var npc_name: String
@export var quest: Quest

@onready var primerDialogo : DialogueSystem = $"Dialogo Quest"
@onready var dialogoDefault : DialogueSystem = $"Dialogo Default"
@onready var quest_icon : ColorRect = $NpcQuestIndicador

@onready var current_dialogue: int = 0
@onready var current_npc_state:STATE = STATE.WAITING

var player_in_range = false
var tiene_dialogo_quest : bool 
var tiene_quest: bool
var node_item: Item

enum STATE {
	TALKING,
	WAITING
}

func _ready(): 
	super._ready()
	quest_icon.hide()
	name = "npc" + npc_name
	my_type = "npc"
	
	if dialogoDefault:
		dialogoDefault.use_item.connect(_on_item_used)
	
	if gives_item != null:
		create_item()
		primerDialogo.deliver_item.connect(new_item)
		
	if primerDialogo.esta_vacio() == false: 
		primerDialogo.use_item.connect(_on_item_used)
		tiene_dialogo_quest = true
		quest_icon.show()
		
	if quest:
		tiene_quest = true
		quest.init()
		quest.quest_ended.connect(on_quest_ended)
		
	

#func _input(event):
	#match current_npc_state:
		#STATE.TALKING:			
			#pass
		#STATE.WAITING:
			#if player_in_range and Input.is_action_just_pressed("ui_accept"):
				#current_npc_state = STATE.TALKING
				#interact()
				#
				#current_npc_state = STATE.WAITING

func dialogueEnded():
	await dialogue_ended
	
func on_quest_ended(title):
	quest_ended.emit(title)

func interact():
	interacted.emit(self)
	await dialogueEnded()
	
func startDialogue():
	if tiene_dialogo_quest == true:
		primerDialogo.set_speaker(self.npc_name)
		primerDialogo.start()
		await primerDialogo.finished
		take_first_dialogue()
		if tiene_quest :
			take_quest()
			
	elif dialogoDefault != null:
		dialogoDefault.set_speaker(self.npc_name)
		dialogoDefault.start()
		await dialogoDefault.finished
	
	
func quest_available():
	return tiene_quest
	
func take_quest():
	quest_icon.hide()
	quest_begun.emit()
	tiene_quest = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "PlayerB":
		InteractionManager.set_interactuable(self)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "PlayerB":
		InteractionManager.clear_interactuable(self)


func _on_dialogo_quest_dialogue_ended() -> void:
	dialogue_ended.emit()


func _on_dialogo_default_dialogue_ended() -> void:
	dialogue_ended.emit()
	
func get_state() -> Dictionary:
	var state = {}
	state["questDialogo"] = tiene_dialogo_quest
	state["process_mode"] = process_mode
	state["quest"] = tiene_quest
	
	return state
	
func load_state(current_state):
	tiene_dialogo_quest = current_state["questDialogo"]
	process_mode = current_state["process_mode"]
	tiene_quest = current_state["quest"]
	
func get_type()  -> String :
	return my_type
	

func new_item(item):
	node_item.interact()

func take_first_dialogue():
	quest_icon.hide()
	tiene_dialogo_quest = false

func create_item() -> Item :
	node_item = Item.new()
	node_item.my_type = "item"
	node_item.id = gives_item
	return node_item
	
func _on_item_used(item_id: String):
	item_used.emit(item_id)
