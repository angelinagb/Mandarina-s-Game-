extends Node2D

var posVector: Vector2
@export var deadzone = 10

func get_normalized_vector() -> Vector2:
	return posVector.normalized()
