extends IsoRoom


var level_completed = false

func _on_npc_quest_ended(title: Variant) -> void:
	$Interactables/Npcs/Npc3.process_mode = Node.PROCESS_MODE_INHERIT


func _on_npc_3_dialogue_ended() -> void:
	if not level_completed :
		$Interactables/Items/Item.interacted.emit()
	
	
func get_state() -> Dictionary:
	return {
		"level_completed": level_completed
	}

func load_state(state: Dictionary) -> void:
	if state.has("level_completed"):
		level_completed = state["level_completed"] 
	
