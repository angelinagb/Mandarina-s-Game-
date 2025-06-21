extends IsoRoom
@onready var texture_rect: TextureRect = $TextureRect
@onready var trans_intro_entrada: Transitioner = $Interactables/Transitioners/trans_intro_entrada


@export var dialogo_intro = PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	intro()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_dialogue_system_dialogue_ended() -> void:
	pass

func intro () :	
	QueueManager.enqueue_event(dialogo_intro)
	await QueueManager.finished


func _on_button_pressed() -> void:
	trans_intro_entrada.interact()
	
