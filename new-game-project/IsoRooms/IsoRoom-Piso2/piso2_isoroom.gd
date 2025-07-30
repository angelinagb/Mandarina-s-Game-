extends IsoRoom #puzzle terrain


@onready var switch: Area2D = $Switch
@onready var switch_2: Area2D = $Switch2
@onready var switch_3: Area2D = $Switch3
@onready var switch_4: Area2D = $Switch4

@onready var lab_3: Label = $"3"
@onready var lab_1: Label = $"1"
@onready var lab_4: Label = $"4"
@onready var lab_2: Label = $"2"

@onready var chica_triste: Npc = $"Interactables/Npcs/Chica Triste"
@onready var chica_triste_2: Npc = $Interactables/Npcs/ChicaTriste2


@onready var puzzle_transitioner: Node2D = $Interactables/Transitioners/Puzzle_Transitioner

@onready var canvas_modulate: CanvasModulate = $CanvasModulate

var colors = ["68c7e7","f8a16a","99c79b","ff7eff",]
var level_completed = false
# Called when the node enters the scene tree for the first time.



func _on_switch_body_entered(body: Node2D, extra_arg_0: int) -> void:
	if body is PlayerB:
		
		match extra_arg_0:
			1: 
				canvas_modulate.color = colors[0]
				lab_3.visible = true	
			2:
				canvas_modulate.color = colors[1]
				lab_1.visible = true
			3: 
				canvas_modulate.color = colors[2]
				lab_4.visible = true
			4: 
				canvas_modulate.color = colors[3]
				lab_2.visible = true



func _on_switch_body_exited(body: Node2D) -> void:
	canvas_modulate.color = "ffffff"
	lab_3.visible = false
	lab_1.visible = false
	lab_4.visible = false
	lab_2.visible = false


func set_up_puzzle():
	
		lab_3.visible = false
		lab_1.visible = false
		lab_4.visible = false
		lab_2.visible = false
	
		switch.visible = true 
		switch.visible = true 
		switch.visible = true 
		switch.visible = true
		
		$Interactables/Transitioners/Puzzle_Transitioner.process_mode = Node.PROCESS_MODE_INHERIT

func get_state() -> Dictionary:
	return {
		"level_completed": level_completed
	}

func load_state(state: Dictionary) -> void:
	if state.has("level_completed"):
		level_completed = state["level_completed"] 


func _on_chica_triste_quest_begun() -> void:
	set_up_puzzle()


func _on_chica_triste_quest_ended(title: Variant) -> void:
	level_completed = true
	


func _on_puzzle_transitioner_unblocked() -> void:
	for node in get_tree().get_nodes_in_group("q1"):
		node.process_mode = Node.PROCESS_MODE_DISABLED
		node.visible = false
	for node in get_tree().get_nodes_in_group("end"):
		node.process_mode = Node.PROCESS_MODE_INHERIT
		node.visible = true

func ready():
	super._ready()
	puzzle_transitioner.unblocked.connect(_on_puzzle_transitioner_unblocked)
