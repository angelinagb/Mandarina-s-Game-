extends Puzzle

signal finished

@onready var grid: GridContainer = $Grid
@onready var label_estado: Label = $Control/Estado
@onready var TAM = $Grid.columns

var start_pos
var end_pos

func _ready():
	start_pos = buscar_posicion("inicio")
	end_pos = buscar_posicion("final")
	actualizar_estado()

func buscar_posicion(tipo_buscado: String) -> Vector2i:
	for y in range(TAM):
		for x in range(TAM):
			var pieza = get_pieza(x, y)
			if pieza and pieza.tipo == tipo_buscado:
				return Vector2i(x, y)
	return Vector2i(-1, -1)

func actualizar_estado():
	if check_circuito():
		label_estado.text = "RESULTADO:\n"+"¡Circuito Completo!"
		super.on_puzzle_result(true)
		finished.emit()
		queue_free()
	else:
		label_estado.text = "RESULTADO:\n"+"Incompleto..."

func get_pieza(x: int, y: int):
	if x < 0 or x >= TAM or y < 0 or y >= TAM:
		return null
	var index = y * TAM + x
	return grid.get_child(index)

func check_circuito() -> bool:
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
	actualizar_estado()
	
