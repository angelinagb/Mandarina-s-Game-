extends Puzzle

@onready var label_pregunta: Label = $Control/Control/Pregunta
@onready var opciones_container: GridContainer = $Control/Opciones
@onready var resultado_label: Label = $Control/Control2/Resultado

@onready var botones = [
	$Control/Opciones/Control/Opcion_1,
	$Control/Opciones/Control2/Opcion_2,
	$Control/Opciones/Control3/Opcion_3
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
		if boton.is_connected("pressed", _on_opcion_presionada):
			boton.pressed.disconnect(_on_opcion_presionada)

		# Conectar nueva opción (usamos lambda para capturar valor)
		boton.pressed.connect(func():
			_on_opcion_presionada(opciones[i])
		)

	resultado_label.text = ""

func _on_opcion_presionada(valor: String):
	var is_correct = valor == serie_actual["respuesta"]
	if is_correct:
		resultado_label.text = "✅ ¡Correcto!"
	else:
		resultado_label.text = "❌ Incorrecto. Era: " + serie_actual["respuesta"]
	
	super.on_puzzle_result(is_correct)
