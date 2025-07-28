extends IsoRoom

@onready var cams_activator: Activator = $Interactables/Cams_Activator
@export var player_think: PackedScene
@onready var item: Key = $Interactables/Items/Item



var already_watched = false

func _ready() -> void:
	super._ready()
	add_to_group("Con Estado")
	cams_activator.end_activable.connect(_on_cams_finished)
	

func _on_cams_finished():
	if not already_watched:
		already_watched = true
		QueueManager.enqueue_event(player_think)
		await QueueManager.finished
		item.interact()

func get_state() -> Dictionary:
	return {
		"cams_watched": already_watched
	}

func load_state(state: Dictionary) -> void:
	if state.has("cams_watched"):
		already_watched = state["cams_watched"]
