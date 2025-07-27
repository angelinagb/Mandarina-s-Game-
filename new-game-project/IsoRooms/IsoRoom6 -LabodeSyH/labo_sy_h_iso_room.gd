extends IsoRoom

@onready var key: Key = $Interactables/Items/Key
@onready var npc_profe: Npc = $Interactables/Npcs/Npc_profe

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	key.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_npc_profe_dialogue_ended() -> void:
	if not key.taken:
		show_key()

func show_key():
	if key.visible == true :
		return 
	key.visible = true
	key.process_mode = Node.PROCESS_MODE_INHERIT
