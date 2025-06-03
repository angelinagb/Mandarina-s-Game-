extends IsoRoom

@export var osc = PackedScene
var player_in_range = false 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("ui_accept"):
		QueueManager.enqueue_event(osc)
		await QueueManager.finished


func _on_oscactivator_body_entered(body: Node2D) -> void:
	if body.name == "PlayerB":
		player_in_range = true
