extends IsoRoom

@export var osc = PackedScene
var player_in_range = false 


func _on_oscactivator_body_entered(body: Node2D) -> void:
		QueueManager.enqueue_event(osc)
		await QueueManager.finished
