extends IsoRoom

@export var dialogo_trap: PackedScene
var level_completed:= false

func _ready() -> void:
	if not level_completed:
		$RoomSounds.play()
		QueueManager.enqueue_event(dialogo_trap)
		level_completed = true
		


func get_state() -> Dictionary:
	return {
		"level_completed": level_completed
	}

func load_state(state: Dictionary) -> void:
	if state.has("level_completed"):
		level_completed = state["level_completed"] 
