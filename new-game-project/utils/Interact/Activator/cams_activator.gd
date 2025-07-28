extends Activator

@export var next: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	activable.end.connect(begin_next)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func begin_next():
	activable = next
	super.interact()
	
