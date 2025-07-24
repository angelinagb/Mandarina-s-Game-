extends IsoRoom

@onready var key: Key = $Interactables/Items/Key

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_npc_profe_dialogue_ended() -> void:
	key.visible = true
