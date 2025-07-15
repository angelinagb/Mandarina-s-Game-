extends Button
class_name BotonDecision


signal boton_decision_elegido

var label : Label
var indice_elemento: int
var decision_icon: TextureRect

func inicializar(texto: String, indice: int,type: String):
	label = $MarginContainer/Label
	decision_icon = $MarginContainer/TextureRect
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	label.text = texto
	indice_elemento = indice
	var tex :=  preload("res://art/menu/Icons_Essential/v1.2/Icons/Info.png")
	print(tex)
	match type: 
		"Quest": decision_icon.texture = preload("res://art/menu/Icons_Essential/v1.2/Icons/Info.png")
		"Quit": decision_icon.texture = preload("res://art/menu/Icons_Essential/v1.2/Icons/Exit.png")
		_: decision_icon.texture = null
	pressed.connect(_on_button_pressed)
	label.queue_redraw()
	
func get_indice_elemento() -> int:
	return indice_elemento
	
	
func _on_button_pressed():
	boton_decision_elegido.emit(indice_elemento)
