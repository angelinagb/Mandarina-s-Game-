extends Puzzle

@onready var objective: Label = $PanelLeft/MarginContainer/VBoxContainer/Objective
@onready var submit: Button = $PanelLeft/MarginContainer/VBoxContainer/Submit
@onready var delete: Button = $PanelLeft/MarginContainer/VBoxContainer/Delete
@onready var actual: Label = $PanelRight/MarginContainer/VBoxContainer/Solution
@onready var label_result: Label = $Response
 
@onready var button_c: Button = $ButtonsTable/Control_C/Button_C
@onready var button_n: Button = $ButtonsTable/Control_N/Button_N
@onready var button_s: Button = $ButtonsTable/Control_S/Button_S
@onready var button_h: Button = $ButtonsTable/Control_H/Button_H
@onready var button_o: Button = $ButtonsTable/Control_O/Button_O


@export var CORRECT_COMBINATION: Dictionary = 	{
												"nombre": "Metano",
												"formula": "CH₄",
												"elementos": {"C": 1, "H": 4}
												}

var ACTUAL_COMBINATION: Array[String] = []
var MAX_ELEMENTS = 6

func _ready():
	button_n.pressed.connect(add_element.bind("N"))
	button_s.pressed.connect(add_element.bind("S"))
	button_h.pressed.connect(add_element.bind("H"))
	button_o.pressed.connect(add_element.bind("O"))
	button_c.pressed.connect(add_element.bind("C"))
	objective.text = "Objetivo: \n" + CORRECT_COMBINATION.nombre
	update_solution_label()

func add_element(elemento: String):
	if ACTUAL_COMBINATION.size() < MAX_ELEMENTS:
		ACTUAL_COMBINATION.append(elemento)
		update_solution_label()
	else:
		update_response_label("¡Son muchos elementos!")
		disable_buttons()
		await get_tree().create_timer(2.0).timeout
		update_response_label("")
		enable_buttons()

func disable_buttons():
	submit.disabled = true
	delete.disabled = true
	button_c.disabled = true
	button_n.disabled = true
	button_s.disabled = true
	button_h.disabled = true
	button_o.disabled = true

func enable_buttons():
	submit.disabled = false
	delete.disabled = false
	button_c.disabled = false
	button_n.disabled = false
	button_s.disabled = false
	button_h.disabled = false
	button_o.disabled = false

func update_solution_label():
	actual.text = "COMPONENTES\n" + "\n".join(ACTUAL_COMBINATION)

func update_response_label(text: String):
	pause()
	label_result.text = text
	await get_tree().create_timer(5.0).timeout
	label_result.text = ""

func sum_elements(lista: Array[String]) -> Dictionary:
	var conteo := {}
	for elemento in lista:
		conteo[elemento] = conteo.get(elemento, 0) + 1
	return conteo

func _on_delete_pressed() -> void:
	ACTUAL_COMBINATION.clear()
	update_solution_label()

func _on_submit_pressed() -> void:
	var conteo_actual = sum_elements(ACTUAL_COMBINATION)
	var is_correct :bool = conteo_actual == CORRECT_COMBINATION["elementos"]
	if is_correct:
		await update_response_label("¡Reacción exitosa! " + CORRECT_COMBINATION.formula)
		end_puzzle(true)
	else:
		await update_response_label("¡Falló la reacción!")
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
	objective.text = "Objetivo: \n" + CORRECT_COMBINATION.nombre
	actual.text = "COMPONENTES\n"
	ACTUAL_COMBINATION = []
	update_solution_label()

func pause():
	submit.disabled = true
	delete.disabled = true
	button_c.disabled = true
	button_n.disabled = true
	button_s.disabled = true
	button_h.disabled = true
	button_o.disabled = true

func resume():
	submit.disabled = false
	delete.disabled = false
	button_c.disabled = false
	button_n.disabled = false
	button_s.disabled = false
	button_h.disabled = false
	button_o.disabled = false
