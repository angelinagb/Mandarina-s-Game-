class_name Quest
extends Resource

@export var title: String
@export var steps: Array[QuestStep] = []
@export var current_step: int = 0

func get_current_step() -> QuestStep:
	if current_step < steps.size():
		return steps[current_step]
	return null

func try_advance_step():
	var step := get_current_step()
	if step and step.is_completed():
		current_step += 1

func is_completed() -> bool:
	return current_step >= steps.size()

func register_interactable(id: String) -> bool:
	var step := get_current_step()
	var response: bool = false
	if step:
		response = step.set_interactable_interacted(id)
		try_advance_step()
	return response
