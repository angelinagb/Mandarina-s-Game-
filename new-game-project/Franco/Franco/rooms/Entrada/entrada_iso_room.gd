extends IsoRoom


func _on_area_2d_body_entered(body: Node2D) -> void:
	QueueManager.enqueue_event(preload("res://Ange/sube.tscn"))
