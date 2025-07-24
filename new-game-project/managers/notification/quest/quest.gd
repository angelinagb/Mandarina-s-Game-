class_name Quest
extends Resource

signal quest_ended(title)


@export var title: String
@export var steps: Array[QuestStep] = []
@export var current_step: int = 0
@export var is_secondary : bool = true

func init():
	for step : QuestStep in steps:
		step.step_completed.connect(on_last_step_completed)

func get_current_step() -> QuestStep:
	if current_step < steps.size():
		return steps[current_step]
	return null

func try_advance_step():
	var step := get_current_step()
	if step and step.is_completed():
		current_step += 1
	
func on_last_step_completed():
	quest_ended.emit(title)

func is_completed() -> bool:
	return current_step >= steps.size()

func register_interactable(id: String) -> bool:
	var step := get_current_step()
	var response: bool = false
	if step:
		response = step.set_interactable_interacted(id)
		try_advance_step()
	return response
