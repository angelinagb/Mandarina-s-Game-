extends Resource
class_name Decision

#STRING, DIALOGUE RESOURCE, CONDICION
@export var array_opciones : Array[Opcion]


func get_texto_opciones() -> PackedStringArray:
	var array_de_texto : PackedStringArray
	var i : int = 0
	while i < array_opciones.size():
		array_de_texto.append(array_opciones[i].get_texto())
		i += 1
	return array_de_texto
	
func get_recurso_dialogo_de_decision_elegida(indice : int) -> Opcion:
	return array_opciones[indice]
 
