class_name Npc extends Interactable

signal quest_begun
signal dialogue_ended
signal quest_ended(title)

@export var quest: Quest
@onready var primerDialogo : DialogueSystem = $"Dialogo Quest"
@onready var dialogoDefault : DialogueSystem = $"Dialogo Default"
@onready var quest_icon : ColorRect = $NpcQuestIndicador
var tiene_quest : bool

@onready var current_dialogue: int = 0
@onready var current_npc_state:STATE = STATE.WAITING

var player_in_range = false

enum STATE {
	TALKING,
	WAITING
}

func _ready():
	quest_icon.hide()
	if primerDialogo.esta_vacio() == false:
		tiene_quest = true
		quest_icon.show()
	my_type = "npc"
	super._ready()
	if quest:
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
	if tiene_quest == true:
		primerDialogo.start()
	else:
		if dialogoDefault != null:
			dialogoDefault.start()
	
	
func quest_available():
	return tiene_quest
	
func take_quest():
	tiene_quest = false
	quest_icon.hide()
	quest_begun.emit()

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
	state["tiene_quest"] = tiene_quest
	state["process_mode"] = process_mode
	return state
	
func load_state(current_state):
	tiene_quest = current_state["tiene_quest"]
	process_mode = current_state["process_mode"]
	
func get_type()  -> String :
	return my_type
