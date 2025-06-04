extends IsoRoom

@export var intro : PackedScene
@onready var trans : Transitioner = $"Interactables/Transitioners/Trans R1 -> R2"
@onready var base_tiles: Node2D = $BaseTiles


func _ready():
	super._ready()
	trans.process_mode = Node.PROCESS_MODE_DISABLED
	#QueueManager.enqueue_event(intro)


func save_state():
	print("guardando estado!")
	super.save_state()


func _on_chica_triste_dialogue_ended() -> void:
	trans.process_mode = Node.PROCESS_MODE_INHERIT
	
