extends Resource
class_name DecisionResource

#STRING, DIALOGUE RESOURCE, CONDICION
@export var opciones_de_dialogo : Array[DecisionElementResource]


func get_texto_opciones() -> PackedStringArray:
	var array_de_texto : PackedStringArray
	var i : int = 0
	while i < opciones_de_dialogo.size():
		array_de_texto.append(opciones_de_dialogo[i].get_texto())
		i += 1
	return array_de_texto
	
func get_recurso_dialogo_de_decision_elegida(indice : int) -> DecisionElementResource:
	return opciones_de_dialogo[indice]
 
