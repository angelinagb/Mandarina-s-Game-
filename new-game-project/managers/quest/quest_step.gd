class_name QuestStep
extends Resource

@export var text_to_do: String
@export var necessary_interactables: Dictionary = {}
# Formato: { "1": false, "5": true, "claveX": false }

func is_completed() -> bool:
	for id in necessary_interactables.keys():
		if not necessary_interactables[id]:
			return false
	return true

func set_interactable_interacted(id: String) -> bool:
	var response: bool = false
	if necessary_interactables.has(id):
		necessary_interactables[id] = true
		response = true
	return response
