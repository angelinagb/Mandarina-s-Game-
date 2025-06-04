extends Puzzle

@onready var submit: Button = $Background/MarginContainer/VBoxContainer/HBoxContainer/Submit

@onready var grid: GridContainer = $Background/MarginContainer/VBoxContainer/Circuit
@onready var label_result: Label = $Background/Result
@onready var TAM = grid.columns

var start_pos: Vector2i
var end_pos: Vector2i

func _ready():
	start_pos = buscar_posicion("inicio")
	end_pos = buscar_posicion("final")

func buscar_posicion(tipo_buscado: String) -> Vector2i:
	for y in range(TAM):
		for x in range(TAM):
			var pieza = get_pieza(x, y)
			if pieza and pieza.tipo == tipo_buscado:
				return Vector2i(x, y)
	return Vector2i(-1, -1)

func check_solution():
	if check_circuit():
		await update_response_label("¡Circuito completo con exito!")
		end_puzzle(true)
	else:
		await update_response_label("Circuito mal hecho")
		open_popup_menu()

func get_pieza(x: int, y: int):
	if x < 0 or x >= TAM or y < 0 or y >= TAM:
		return null
	var index = y * TAM + x
	return grid.get_child(index)

func check_circuit() -> bool:
	var visitados = {}
	var cola = [start_pos]

	while cola.size() > 0:
		var actual = cola.pop_front()
		if actual == end_pos:
			return true

		visitados[actual] = true

		var pieza = get_pieza(actual.x, actual.y)
		if pieza == null:
			continue

		var conexiones = pieza.get_conexiones()
		for dir in conexiones:
			var offset := Vector2i.ZERO
			match dir:
				"up": offset = Vector2i(0, -1)
				"down": offset = Vector2i(0, 1)
				"left": offset = Vector2i(-1, 0)
				"right": offset = Vector2i(1, 0)

			var vecino_pos = actual + offset
			if vecino_pos in visitados:
				continue

			var vecino = get_pieza(vecino_pos.x, vecino_pos.y)
			if vecino == null:
				continue

			# Saltar piezas tipo "base" que no conectan
			if vecino.tipo == "base":
				continue

			# Determinar dirección opuesta
			var opuesta := ""
			match dir:
				"up": opuesta = "down"
				"down": opuesta = "up"
				"left": opuesta = "right"
				"right": opuesta = "left"

			if opuesta in vecino.get_conexiones():
				cola.append(vecino_pos)

	return false

func _on_button_pressed() -> void:
	check_solution()

func open_popup_menu():
	popupmenu_instance = load(POPUPMENU_PATH).instantiate()
	popupmenu_instance.replay_pressed.connect(on_replay_pressed)
	popupmenu_instance.out_pressed.connect(on_out_pressed)
	add_child(popupmenu_instance)

func on_replay_pressed():
	restart_puzzle()

func on_out_pressed():
	end_puzzle(false)

func end_puzzle(result: bool):
	super.on_puzzle_result(result)
	super.end()

func restart_puzzle():
	resume()
	for child in grid.get_children():
		child.rotacion_actual = 0

func update_response_label(text: String):
	pause()
	label_result.text = text
	await get_tree().create_timer(5.0).timeout
	label_result.text = ""

func pause():
	submit.disabled = true
	for child in grid.get_children():
		child.mouse_filter = Control.MOUSE_FILTER_IGNORE

func resume():
	submit.disabled = false
	for child in grid.get_children():
		child.mouse_filter = Control.MOUSE_FILTER_STOP
