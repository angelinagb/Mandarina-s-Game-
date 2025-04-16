class_name transitioner extends Area2D

@export var destiny: int
@export var path_scene: String

@onready var destinyRoom: PackedScene = load(path_scene)

func getDestiny():
	return destiny

func getDestinyRoom():
	return destinyRoom
