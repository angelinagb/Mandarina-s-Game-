extends Node
var room_states = {}  # Dictionary<String, Dictionary>

func get_room_state(room_id: String) -> Dictionary:
	return room_states.get(room_id, {})

func save_room_state(room_id: String, state: Dictionary) -> void:
	room_states[room_id] = state
