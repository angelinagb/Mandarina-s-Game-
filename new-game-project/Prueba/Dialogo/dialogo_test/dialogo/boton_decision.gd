extends Button
class_name BotonDecision

signal boton_decision_elegido


var label : Label
var indice_elemento: int

func inicializar(texto: String, indice: int):
	label = $Label
	label.text = texto
	indice_elemento = indice
	pressed.connect(_on_button_pressed)
	
func get_indice_elemento() -> int:
	return indice_elemento
	
	
func _on_button_pressed():
	boton_decision_elegido.emit(indice_elemento)
