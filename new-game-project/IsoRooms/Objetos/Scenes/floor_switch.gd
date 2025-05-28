extends Item

@onready var swich_floor_1: Sprite2D = $SwichFloor1



func _ready() -> void:
	swich_floor_1.frame = 0
	interaction = Callable(self,"switch_interaction")

func pressed(state: bool) : 
	if state:
		swich_floor_1.frame = 1
	else: 
		swich_floor_1.frame = 0 


func switch_interaction() : 
	pass
