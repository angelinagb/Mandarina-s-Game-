extends IsoRoom

@onready var item: Item = $Interactables/Items/Item

var level_completed

func _ready() -> void:
	super._ready()
	if not level_completed:
		item.visible = false
		$Interactables/Items/Item/Area2D.visible = false

func _on_npc_dialogue_ended() -> void:
	if not level_completed:
		item.visible = true
		$Interactables/Items/Item/Area2D.visible = true

func get_state() -> Dictionary:
	return {
		"level_completed": level_completed
	}

func load_state(state: Dictionary) -> void:
	if state.has("level_completed"):
		level_completed = state["level_completed"] 
