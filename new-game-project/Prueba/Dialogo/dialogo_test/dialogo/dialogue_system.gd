extends Node2D
class_name DialogueSystem

signal dialogue_ended

@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var rich_text_label : RichTextLabel = $CanvasLayer/ColorRect2/MarginContainer/VBoxContainer/RichTextLabel
@onready var timer : Timer = $Timer
@export var boton_decision : PackedScene
@onready var margin_container : MarginContainer = $CanvasLayer/ColorRect2/MarginContainer
@onready var v_box_container : VBoxContainer = $CanvasLayer/ColorRect2/MarginContainer/VBoxContainer
var decision_actual : DecisionResource

##Recurso con información sobre el diálogo a mostrar
@export var dialogueResource : DialogueResource
@onready var canvas_layer : CanvasLayer = $CanvasLayer
## while text not empty
var i : int
var j : int
var text_length : int
var text_count : int
var current_state : States

enum States {ABRIENDO, MOSTRANDO_TEXTO, TEXTO_MOSTRADO, CERRANDO}


func _ready() -> void:
	canvas_layer.hide()
	inicializar_conversacion()
	
	#ESTO ESTA SOLO PARA TESTEAR LA ESCENA, SE TIENE QUE COMENTAR Y LLAMAR DESDE OTRO
	#SCRIPT START PARA COMENZAR EL DIALOGO!
	start()
	
func inicializar_conversacion() -> void:
	text_count = dialogueResource.get_dialogue_count()
	if text_count > 0:
		text_length = dialogueResource.get_dialogue_text(0).length()
	i = 0
	j = 0
	timer.wait_time = dialogueResource.get_dialogue_speed()
	rich_text_label.text = ""
	current_state = States.ABRIENDO
	
func mostrar_decision():
	var i : int = 0
	var aux_boton : BotonDecision
	while i < decision_actual.get_texto_opciones().size():
		rich_text_label.queue_free()
		#CREO UN BOTON POR CADA DECISION Y CONECTO AL EVENTO
		aux_boton = boton_decision.instantiate()
		aux_boton.inicializar(decision_actual.get_texto_opciones()[i],i)
		aux_boton.boton_decision_elegido.connect(_on_boton_decision_pressed)
		v_box_container.add_child(aux_boton)
		i += 1
		

##Comienza el dialogo, si layer es mayor que 0 se le asigna ese valor al canvas_layer
func start(layer: float = -1):
	if layer > 0:
		canvas_layer.layer = layer
	if text_count > 0:
		canvas_layer.show()
		anim_player.play("fade_in")
	else:
		destruir()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and current_state == States.TEXTO_MOSTRADO:
		next_text()	

func terminar_texto():
	i = text_length
	rich_text_label.text = dialogueResource.get_dialogue_text(j)

func read_text():
	if i < text_length:
		#voy agregando caracteres de a uno
		rich_text_label.text += dialogueResource.get_dialogue_text(j)[i]
		i += 1
		timer.start()
	else:
		current_state = States.TEXTO_MOSTRADO
		
func _on_timer_timeout() -> void:
	read_text()

func next_text():
	j += 1
	if j < text_count:
		##hay otro texto por mostrar
		rich_text_label.text = ""
		i = 0
		current_state = States.MOSTRANDO_TEXTO
		text_length = dialogueResource.get_dialogue_text(j).length()
		read_text()
	else:
		if dialogueResource.get_recurso_decision() != null:
			decision_actual = dialogueResource.get_recurso_decision()
			mostrar_decision()
		else:	
			current_state = States.CERRANDO
			anim_player.play("fade_out")
		
func destruir():
	dialogue_ended.emit()
	queue_free()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		current_state = States.MOSTRANDO_TEXTO
		read_text()
	else:
		destruir()
		
func cambiar_a_modo_conversacion():
	v_box_container.queue_free()
	v_box_container = VBoxContainer.new()
	rich_text_label = RichTextLabel.new()
	rich_text_label.add_theme_font_size_override("normal_font_size",25)
	rich_text_label.custom_minimum_size = Vector2(0,100)
	margin_container.add_child(v_box_container)
	v_box_container.add_child(rich_text_label)
		

		
func _on_boton_decision_pressed(indice : int):
	#TENGO QUE ELIMINAR TODOS LOS BOTONES DEL DIALOGO
	cambiar_a_modo_conversacion()
	dialogueResource = decision_actual.get_recurso_dialogo_de_decision_elegida(indice).get_recurso_dialogo()
	inicializar_conversacion()
	start()
