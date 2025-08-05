extends Area2D

@onready var swich_floor_1: Sprite2D = $SwichFloor1



func _ready() -> void:
	swich_floor_1.frame = 0



func _on_body_entered(body: Node2D) -> void:
	swich_floor_1.frame = 1


func _on_body_exited(body: Node2D) -> void:
	swich_floor_1.frame = 0
