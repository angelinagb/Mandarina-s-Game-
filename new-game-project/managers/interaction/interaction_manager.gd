extends Node

var interactuable_actual: Interactable = null
signal interactuable_cambiado(interactuable: Interactable)

func set_interactuable(i):
	interactuable_actual = i
	emit_signal("interactuable_cambiado", i)

func clear_interactuable(i):
	if interactuable_actual == i:
		interactuable_actual = null
		emit_signal("interactuable_cambiado", null)

func interact():
	if interactuable_actual:
		interactuable_actual.interact()
	else :
		print("NO HAY NADA, NO ESTAS HACIENDO NADA")
