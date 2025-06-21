extends Puzzle

@onready var label_pregunta: Label = $Panel/MarginContainer/VBoxContainer/Question
@onready var opciones_container: HBoxContainer = $Panel/MarginContainer/VBoxContainer/HBoxContainer
@onready var label_result: Label = $Panel/Result

@onready var botones = [
	$Panel/MarginContainer/VBoxContainer/HBoxContainer/Option1,
	$Panel/MarginContainer/VBoxContainer/HBoxContainer/Option2,
	$Panel/MarginContainer/VBoxContainer/HBoxContainer/Option3
]

var series = [
	{
		"pregunta": "1, 2, 3, 5, 8, ?",
		"opciones": ["10", "13", "15"],
		"respuesta": "13"
	},
	{
		"pregunta": "2, 4, 8, 16, ?",
		"opciones": ["20", "32", "18"],
		"respuesta": "32"
	},
	{
		"pregunta": "10, 7, 4, 1, ?",
		"opciones": ["-2", "0", "2"],
		"respuesta": "-2"
	},
	{
		"pregunta": "1, 4, 9, 16, ?",
		"opciones": ["20", "25", "30"],
		"respuesta": "25"
	}
]

var serie_actual = {}

func _ready():
	# Elegir una serie aleatoria
	serie_actual = series[randi() % series.size()]

	# Mostrar la pregunta
	label_pregunta.text = serie_actual["pregunta"]

	# Mezclar opciones de forma aleatoria
	var opciones = serie_actual["opciones"].duplicate()
	opciones.shuffle()

	# Asignar texto y conectar señales a los botones ya existentes
	for i in range(botones.size()):
		var boton = botones[i]
		boton.text = opciones[i]

		# Primero desconectamos cualquier conexión previa para evitar duplicados
		if boton.is_connected("pressed", _on_option_presionada):
			boton.pressed.disconnect(_on_option_presionada)

		# Conectar nueva opción (usamos lambda para capturar valor)
		boton.pressed.connect(func():
			_on_option_presionada(opciones[i])
		)

func _on_option_presionada(valor: String):
	var is_correct = valor == serie_actual["respuesta"]
	if is_correct:
		await update_response_label("✅ ¡Correcto!")
		end_puzzle(true)
	else:
		await update_response_label("❌ Incorrecto. Era: " + serie_actual["respuesta"])
		open_popup_menu()

func open_popup_menu():
	self.visible = false
	popupmenu_instance = load(POPUPMENU_PATH).instantiate()
	popupmenu_instance.replay_pressed.connect(on_replay_pressed)
	popupmenu_instance.out_pressed.connect(on_out_pressed)
	add_child(popupmenu_instance)

func on_replay_pressed():
	restart_puzzle()
	self.visible = true

func on_out_pressed():
	end_puzzle(false)

func end_puzzle(result: bool):
	super.on_puzzle_result(result)
	super.end()

func restart_puzzle():
	resume()
	# Elegir una serie aleatoria
	serie_actual = series[randi() % series.size()]

	# Mostrar la pregunta
	label_pregunta.text = serie_actual["pregunta"]

	# Mezclar opciones de forma aleatoria
	var opciones = serie_actual["opciones"].duplicate()
	opciones.shuffle()

	# Asignar texto y conectar señales a los botones ya existentes
	for i in range(botones.size()):
		var boton = botones[i]
		boton.text = opciones[i]

		# Primero desconectamos cualquier conexión previa para evitar duplicados
		if boton.is_connected("pressed", _on_option_presionada):
			boton.pressed.disconnect(_on_option_presionada)

		# Conectar nueva opción (usamos lambda para capturar valor)
		boton.pressed.connect(func():
			_on_option_presionada(opciones[i])
		)

func update_response_label(text: String):
	pause()
	label_result.text = text
	await get_tree().create_timer(5.0).timeout
	label_result.text = ""

func pause():
	for child in botones:
		child.disabled = true

func resume():
	for child in botones:
		child.disabled = false
