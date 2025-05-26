class_name Npc extends Interactable


signal give_quest(quest: Quest)
signal dialogue_ended

@export var quest: Quest
@onready var primerDialogo : DialogueSystem = $"Dialogo Quest"
@onready var dialogoDefault : DialogueSystem = $"Dialogo Default"
@onready var quest_icon : ColorRect = $NpcQuestIndicador
var tiene_quest : bool

var player_in_range = true 
@onready var current_dialogue: int = 0
@onready var current_npc_state:STATE = STATE.WAITING


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
	$Name.text = npc_name
		

func _input(event):
	match current_npc_state:
		STATE.TALKING:			
			pass
		STATE.WAITING:
			if player_in_range and Input.is_action_just_pressed("ui_accept"):
				current_npc_state = STATE.TALKING
				interact()
				await dialogueEnded()
				current_npc_state = STATE.WAITING

func dialogueEnded():
	await dialogue_ended

func interact():
	interacted.emit(self)

func startDialogue():
	if tiene_quest == true:
		primerDialogo.start()
	else:
		dialogoDefault.start()
	
	
func quest_available():
	return tiene_quest
	
func take_quest():
	tiene_quest = false
	quest_icon.hide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = false


func _on_dialogo_quest_dialogue_ended() -> void:
	dialogue_ended.emit()


func _on_dialogo_default_dialogue_ended() -> void:
	dialogue_ended.emit()
