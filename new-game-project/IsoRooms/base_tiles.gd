extends Node2D

@onready var walls_front: TileMapLayer = $walls_front

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

	
func toogle_walls_front_visibility():
	if walls_front.visible == true:
		walls_front.visible = false
	else: 
		walls_front.visible = true
