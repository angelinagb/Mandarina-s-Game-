extends CanvasLayer

signal finished
@export var palabra : String = "Palabra"
@export var pista : String = "Pista"
@export var burbuja_palabra : PackedScene
@export var intentos : int = 5
@export var velocidad_burbujas : float
@onready var vidas_label : Label = $MarginContainer/VBoxContainer/vidas_label
@onready var timer : Timer = $Timer 
@onready var palabra_label : Label = $palabra_label
@onready var palabra_parcial : String
@onready var pista_label : Label = $MarginContainer/VBoxContainer/pista_label
@onready var fondo_pantalla_derrota = $Fondo
var abecedario : String
var current_tries : int = 0

func start():
	initialize()
	while(current_tries > 0 and palabra_label.text != palabra):
		timer.start(.5)
		await timer.timeout
		spawn_burbuja()

func letra_random(palabra : String):
	#de este modo hay mas chances de que salga una letra de la palabra
	var letras = abecedario + palabra + palabra
	return letras[randi()% letras.length()]

func initialize():
	set_palabra_label()
	init_palabra_parcial()
	current_tries = intentos
	update_vidas_restantes()
	abecedario = 'abcdefghijklmnoprstuvwxyz' + palabra + palabra + palabra + palabra
	
func update_vidas_restantes():
	vidas_label.text = "VIDAS RESTANTES = " + str(current_tries)
	
func spawn_burbuja():
	var instance_burbuja : burbuja_letra = burbuja_palabra.instantiate()
	add_child(instance_burbuja)
	instance_burbuja.initialize(letra_random(palabra), (randi() % 2) == 1, velocidad_burbujas)
	instance_burbuja.clicked_on.connect(on_burbuja_clicked_on)

func set_palabra_label():
	var length = palabra.length()
	palabra_label.text = ""
	while length != 0:
		length -= 1
		palabra_label.text += "_ " 
		
func init_palabra_parcial():
	palabra_parcial = ""
	for letra in palabra:
		palabra_parcial += "_"
		
func update_palabra_label():
	palabra_label.text = ""
	for letra : String in palabra_parcial:
		palabra_label.text += letra + " "

func end():
	finished.emit()
	queue_free()
	
func check_win_condition():
	if palabra.to_upper() == palabra_parcial.to_upper():
		end()
		
func remove_letter(letra : String):
	abecedario = abecedario.to_upper().replace(letra.to_upper(), "")
	
func lose():
	fondo_pantalla_derrota.show()
	
	
func on_burbuja_clicked_on(letra : String):
	if palabra.to_upper().contains(letra.to_upper()) && !palabra_label.text.to_upper().contains(letra.to_upper()):
		var from : int = 0
		var index : int = palabra.to_upper().find(letra.to_upper(), from)
		while(index != -1):
			palabra_parcial[index] = letra
			from = index + 1
			if from < palabra.length():
				#queda parte de palabra por analizar
				index = palabra.to_upper().find(letra.to_upper(), from)
			else:
				index = -1
		remove_letter(letra)
		update_palabra_label()
		check_win_condition()
	else:
		#exploto burbuja equivocada
		current_tries -= 1
		update_vidas_restantes()
		if current_tries == 0:
			lose()


func _on_boton_reintentar_pressed() -> void:
	start()
	fondo_pantalla_derrota.hide()
