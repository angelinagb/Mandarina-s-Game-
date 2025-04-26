extends Resource
class_name Ability
#Podemos hacer que cada habilidad extienda de esta y cargarle toda la data si hubiera mas 
@export var name : String 
@export var level: int
@export var max_level: int


func _init(name : String = "Default"):
	self.name = name 
	level = 0
	max_level = 5
	
func can_level_up() -> bool:
	return level < max_level
	
func level_up()-> bool: 
	if can_level_up():
		level += 1 
		return true
	return false
