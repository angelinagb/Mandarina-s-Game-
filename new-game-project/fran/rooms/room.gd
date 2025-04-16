class_name Room extends Node2D

@export var myName: String
@export var adjacentRoom: Array[int]

func _ready():
	pass
	
func getMyName():
	return myName

func get_adjacent():
	return adjacentRoom

func getPositionSpawn(entered_from):
	pass

func getPositionDefect():
	return $SpawnDefect.position

func getTileMapLayer():
	return $TileMapLayer
