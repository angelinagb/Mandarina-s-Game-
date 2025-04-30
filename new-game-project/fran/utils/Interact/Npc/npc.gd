class_name Npc extends Interactable

signal give_quest(quest: Quest)

@export var dialogues: Array[String]
@export var quest: Quest

var quest_status = true

@onready var current_dialogue: int = 0
@onready var current_npc_state:STATE = STATE.WAITING

var player_in_range = false

enum STATE {
	TALKING,
	WAITING
}

func _ready():
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

func getDialogue():
	return dialogues.get(current_dialogue)

func stopped_talking():
	current_npc_state = STATE.WAITING
	if dialogues.size()-1 > current_dialogue:
		current_dialogue += 1

func quest_available():
	return quest_status
	
func take_quest():
	quest_status = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = false
