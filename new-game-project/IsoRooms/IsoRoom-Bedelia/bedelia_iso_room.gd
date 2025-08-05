extends IsoRoom

@onready var npc_3: Npc = $Interactables/Npcs/Npc3
@onready var key: Key = $Interactables/Items/Key
@onready var npc: Npc = $Interactables/Npcs/Npc

var level_completed = false

func _on_npc_quest_ended(title: Variant) -> void:
	for node in get_tree().get_nodes_in_group("end"):
		if node.process_mode == Node.PROCESS_MODE_DISABLED:
			node.process_mode = Node.PROCESS_MODE_INHERIT
		else:
			node.process_mode = Node.PROCESS_MODE_DISABLED
	
func _on_npc_3_dialogue_ended() -> void:
	if not level_completed :
		key.interact()
		level_completed = true
	
	
func get_state() -> Dictionary:
	return {
		"level_completed": level_completed
	}

func load_state(state: Dictionary) -> void:
	if state.has("level_completed"):
		level_completed = state["level_completed"] 

func _ready() -> void:
	super._ready()
	key.visible = false
