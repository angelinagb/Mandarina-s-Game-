extends Puzzle

@onready var objective: Label = $Control2/VBoxContainer/Objective
@onready var submit: Button = $Control2/VBoxContainer/Submit
@onready var delete: Button = $Control2/VBoxContainer/Delete
@onready var actual: Label = $Control/Actual
@onready var resultado: Label = $"Pantalla completa/Resultado"

var POSIBLE_COMBINATION : Array = [
	{"nombre": "Agua", "formula": "H₂O", "elementos": {"H": 2, "O": 1}},
	{"nombre": "Peróxido\nde\nhidrógeno", "formula": "H₂O₂", "elementos": {"H": 2, "O": 2}},
	{"nombre": "Radical\nhidroxilo", "formula": "HO", "elementos": {"H": 1, "O": 1}},
	{"nombre": "Hidrógeno\nmolecular", "formula": "H₂", "elementos": {"H": 2}},
	{"nombre": "Oxígeno\nmolecular", "formula": "O₂", "elementos": {"O": 2}},
	{"nombre": "Agua\noxigenada\ndiluida", "formula": "H₂O + H₂O₂", "elementos": {"H": 4, "O": 3}},
	{"nombre": "Metano", "formula": "CH₄", "elementos": {"C": 1, "H": 4}},
	{"nombre": "Etanol", "formula": "C₂H₆O", "elementos": {"C": 2, "H": 6, "O": 1}},
	{"nombre": "Metanol", "formula": "CH₄O", "elementos": {"C": 1, "H": 4, "O": 1}},
	{"nombre": "Propano", "formula": "C₃H₈", "elementos": {"C": 3, "H": 8}},
	{"nombre": "Butano", "formula": "C₄H₁₀", "elementos": {"C": 4, "H": 10}}
]

var ACTUAL_COMBINATION: Array[String] = []

var CORRECT_COMBINATION = POSIBLE_COMBINATION[randi() % POSIBLE_COMBINATION.size()]

func _ready():
	$"Pantalla completa".mouse_filter = Control.MOUSE_FILTER_IGNORE
	objective.text = "Objetivo: \n" + CORRECT_COMBINATION.nombre
	$Control_N/Button_N.pressed.connect(agregar_elemento.bind("N"))
	$Control_S/Button_S.pressed.connect(agregar_elemento.bind("S"))
	$Control_H/Button_H.pressed.connect(agregar_elemento.bind("H"))
	$Control_O/Button_O.pressed.connect(agregar_elemento.bind("O"))
	$Control_C/Button_C.pressed.connect(agregar_elemento.bind("C"))
	submit.pressed.connect(_submit_combination)
	delete.pressed.connect(_delete_combination)
	actualizar_label()

func agregar_elemento(elemento: String):
	ACTUAL_COMBINATION.append(elemento)
	actualizar_label()

func actualizar_label():
	actual.text = "COMPONENTES\n" + "\n".join(ACTUAL_COMBINATION)

func contar_elementos(lista: Array[String]) -> Dictionary:
	var conteo := {}
	for elemento in lista:
		conteo[elemento] = conteo.get(elemento, 0) + 1
	return conteo
	
func _submit_combination():
	var conteo_actual = contar_elementos(ACTUAL_COMBINATION)
	var is_correct :bool = conteo_actual == CORRECT_COMBINATION["elementos"]
	
	if not resultado.label_settings:
		resultado.label_settings = LabelSettings.new()

	if is_correct:
		resultado.text = "¡Reacción exitosa!"
		resultado.label_settings.font_color = Color(0, 1, 0)
	else:
		resultado.text = "¡Falló la reacción!"
		resultado.label_settings.font_color = Color(1, 0, 0)

	super.on_puzzle_result(is_correct)

func _delete_combination():
	ACTUAL_COMBINATION.clear()
	actualizar_label()
