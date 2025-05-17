extends Resource
class_name Condicion

enum ATTRIBUTE_TYPE { CARISMA, INTELIGENCIA, FUERZA}


@export var atributo: ATTRIBUTE_TYPE
@export var numero : int


func get_atributo_id() -> int:
	return atributo
	

func get_numero() -> int:
	return numero
