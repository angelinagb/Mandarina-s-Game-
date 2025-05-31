extends Puzzle

@onready var resultado_label: Label = $Control2/ResultadoLabel
@onready var digit_labels := [
	$Control/GridContainer/Digito_1,
	$Control/GridContainer/Digito_2,
	$Control/GridContainer/Digito_3,
	$Control/GridContainer/Digito_4
]
@onready var color_feedback := [
	$Control3/GridContainer/Feedback_1,
	$Control3/GridContainer/Feedback_2,
	$Control3/GridContainer/Feedback_3,
	$Control3/GridContainer/Feedback_4
]
@onready var fallos_label: RichTextLabel = $Control4/FallosLabel
@onready var restantes_label: Label = $Control5/RestantesLabel
@onready var reset_timer: Timer = $ResetTimer

var codigo_secreto: Array = []
var intento_actual: Array = []
var intentos_maximos := 6
var intentos_realizados := 0
var historial_de_fallos_texto := ""

func _ready():
	generar_codigo_secreto()
	actualizar_ui()
	fallos_label.bbcode_enabled = true

	# Conectar botones 0 al 9
	for i in range(10):
		var boton = $Control6/Botonera.get_node(str(i))
		boton.pressed.connect(_on_boton_num_presionado.bind(i))

	reset_timer.timeout.connect(_on_reset_timer_timeout)

func generar_codigo_secreto():
	var posibles := []
	for i in range(10):
		posibles.append(i)
	posibles.shuffle()
	codigo_secreto = posibles.slice(0, 4)
	print("Código secreto:", codigo_secreto)  # Quitar en producción

func _on_boton_num_presionado(digito: int):
	if intento_actual.size() < 4:
		intento_actual.append(digito)
		digit_labels[intento_actual.size() - 1].text = str(digito)

	if intento_actual.size() == 4:
		comprobar_intento()

func comprobar_intento():
	intentos_realizados += 1
	var feedback := calcular_feedback()
	mostrar_feedback_colores(feedback)
	
	var is_correct = intento_actual == codigo_secreto
	if is_correct:
		resultado_label.text = "¡Éxito!"
		super.on_puzzle_result(is_correct)
	else:
		resultado_label.text = "Falla"

		# Mostrar intento con colores
		var colores_bbcode := {
			"green": "[color=green]",
			"yellow": "[color=yellow]",
			"red": "[color=red]",
		}

		var linea_coloreada := ""
		for i in range(4):
			var digito := str(intento_actual[i])
			var color_tag: String = colores_bbcode.get(feedback[i], "[color=white]")
			linea_coloreada += color_tag + digito + "[/color]"

		historial_de_fallos_texto += linea_coloreada + "\n"
		fallos_label.text = "Fallos\n" + historial_de_fallos_texto

		# Actualizar intentos restantes
		var restantes = intentos_maximos - intentos_realizados
		restantes_label.text = "Intentos\n" + str(restantes)

		if restantes <= 0:
			resultado_label.text = "¡Sin intentos!"
			super.on_puzzle_result(is_correct)
		else:
			reset_timer.start()
			desactivar_botones()

	# Preparar para siguiente intento
	intento_actual.clear()
	for lbl in digit_labels:
		lbl.text = "_"

func calcular_feedback() -> Array:
	var feedback = []
	var usados_secreto = []
	var usados_intento = []

	# Verdes: aciertos exactos
	for i in range(4):
		if intento_actual[i] == codigo_secreto[i]:
			feedback.append("green")
			usados_secreto.append(i)
			usados_intento.append(i)
		else:
			feedback.append(null)

	# Amarillos: aciertos en número pero no en posición
	for i in range(4):
		if feedback[i] != null:
			continue
		var digito = intento_actual[i]
		var encontrado := false
		for j in range(4):
			if j in usados_secreto:
				continue
			if codigo_secreto[j] == digito:
				encontrado = true
				usados_secreto.append(j)
				break
		feedback[i] = "yellow" if encontrado else "red"
	return feedback

func mostrar_feedback_colores(feedback: Array):
	var color_mapa = {
		"green": Color(0, 1, 0),
		"yellow": Color(1, 1, 0),
		"red": Color(1, 0, 0),
		"_": Color(0, 0, 0, 0)
	}
	for i in range(4):
		color_feedback[i].color = color_mapa.get(feedback[i], Color(0, 0, 0, 0))

func desactivar_botones():
	for i in range(10):
		$Control6/Botonera.get_node(str(i)).disabled = true

func activar_botones():
	for i in range(10):
		$Control6/Botonera.get_node(str(i)).disabled = false

func actualizar_ui():
	resultado_label.text = "Esperando intento"
	fallos_label.text = "Fallos\n"
	restantes_label.text = "Intentos\n" + str(intentos_maximos)
	for lbl in digit_labels:
		lbl.text = "_"
	for rect in color_feedback:
		rect.color = Color(0, 0, 0, 0)

func _on_reset_timer_timeout():
	resultado_label.text = "Esperando intento"
	for rect in color_feedback:
		rect.color = Color(0, 0, 0, 0)
	activar_botones()
