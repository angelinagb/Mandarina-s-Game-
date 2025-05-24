extends Resource
class_name Dialogo


@export var arreglo_de_textos : PackedStringArray
@export var decision : Decision

#Tiempo que se va a esperar para mostrar el siguiente caräcter del texto
@export var tiempo_entre_caracteres : float = .02

var current_text : int

func init():
	current_text = 0

func get_dialogue_count() -> int:
	return arreglo_de_textos.size()

func get_dialogue_text(i: int) -> String:
		return arreglo_de_textos[i]
	
func get_recurso_decision() -> Decision:
	return decision	
	
func get_dialogue_speed() -> float:
	return tiempo_entre_caracteres
