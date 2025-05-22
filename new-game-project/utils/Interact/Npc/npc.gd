class_name Npc extends Interactable

signal give_quest(quest: Quest)

@export var quest: Quest
@onready var primerDialogo : DialogueSystem = $"Dialogo Quest"
@onready var dialogoDefault : DialogueSystem = $"Dialogo Default"
var tiene_quest : bool

@onready var current_dialogue: int = 0
@onready var current_npc_state:STATE = STATE.WAITING

var player_in_range = false

enum STATE {
	TALKING,
	WAITING
}

func _ready():
	if primerDialogo.esta_vacio() != false:
		tiene_quest = true
	my_type = "npc"
	super._ready()

func _input(event):
	match current_npc_state:
		STATE.TALKING:			
			pass
		STATE.WAITING:
			if player_in_range and Input.is_action_just_pressed("ui_accept"):
				current_npc_state = STATE.TALKING
				interact()

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

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = false
