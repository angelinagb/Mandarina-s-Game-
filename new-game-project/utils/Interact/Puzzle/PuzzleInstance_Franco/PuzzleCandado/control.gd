extends Control

var dragging := false
var drag_start_y := 0.0
var current_offset := 0.0  # Posición acumulada para el scroll
var number_height := 32  # Altura de cada número
var selected_index := 0

func get_selected_number() -> int:
	return selected_index

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				if get_global_rect().has_point(event.position):
					dragging = true
					drag_start_y = event.position.y
			else:
				if dragging:
					dragging = false
					# Redondear al número más cercano al soltar
					selected_index = int(round(current_offset / number_height)) % 10
					update_number_display()

	elif event is InputEventMouseMotion and dragging:
		var dy = event.relative.y
		current_offset += dy
		current_offset = clamp(current_offset, 0, number_height * 9)
		update_number_display()

func update_number_display():
	# Lógica para mostrar sólo el número actual según el offset
	var index = int(round(current_offset / number_height)) % 10
	for i in range(10):
		var label = $VBoxContainer.get_child(i)
		label.visible = (i == index)
