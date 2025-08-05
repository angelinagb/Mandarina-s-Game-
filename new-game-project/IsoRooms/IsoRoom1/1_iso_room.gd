extends IsoRoom

@export var intro : PackedScene
@onready var trans : Transitioner = $"Interactables/Transitioners/Trans R1 -> R2"
@onready var item: Key = $Interactables/Items/Item


func _ready():
	super._ready()
	#trans.process_mode = Node.PROCESS_MODE_DISABLED
	#QueueManager.enqueue_event(intro)


func save_state():
	print("guardando estado!")
	super.save_state()



func _on_capitulo_2_interacted(interactable: Interactable) -> void:
	item.interact()
