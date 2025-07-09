extends Node2D
class_name DialogueSystem

#TODO señales si hay exito o falla el chequeo de hablidad
#no deberia activarse de vuelta la animacion cuando empieza recursivamente otro dialogo
signal dialogue_ended
signal finished
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var next_text_button: Button = $CanvasLayer/PanelContainer/next_text_button
@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var rich_text_label : RichTextLabel = $CanvasLayer/PanelContainer/VBoxContainer/RichTextLabel
@onready var timer : Timer = $Timer
@export var boton_decision : PackedScene
@onready var margin_container : PanelContainer = %PanelContainer
@onready var v_box_container : VBoxContainer = %VBoxContainer
@export var destruirse_al_finalizar : bool
var decision_actual : Decision
@export var vacio : bool

##Recurso con información sobre el diálogo a mostrar
@export var dialogueResource : Dialogo
@onready var canvas_layer : CanvasLayer = $CanvasLayer
## while text not empty
var i : int
var j : int
var text_length : int
var text_count : int
var current_state : States

enum States {ABRIENDO, MOSTRANDO_TEXTO, TEXTO_MOSTRADO, CERRANDO, MOSTRANDO_DECISIONES}



func _ready() -> void:
	canvas_layer.hide()
	inicializar_conversacion()
	
func esta_vacio() -> bool:
	return vacio


func inicializar_conversacion() -> void:
	text_count = dialogueResource.get_dialogue_count()
	if text_count > 0:
		text_length = dialogueResource.get_dialogue_text(0).length()
	i = 0
	j = 0
	timer.wait_time = dialogueResource.get_dialogue_speed()
	rich_text_label.text = ""
	current_state = States.ABRIENDO

@warning_ignore("shadowed_variable")
func mostrar_decision():
	set_button_visibility(false)
	current_state = States.MOSTRANDO_DECISIONES
	var i : int = 0
	var aux_boton : BotonDecision
	rich_text_label.queue_free()
	while i < decision_actual.get_texto_opciones().size():
		#CREO UN BOTON POR CADA DECISION Y CONECTO AL EVENTO
		aux_boton = boton_decision.instantiate()
		aux_boton.inicializar(decision_actual.get_texto_opciones()[i],i)
		aux_boton.boton_decision_elegido.connect(_on_boton_decision_pressed)
		v_box_container.add_child(aux_boton)
		i += 1
##Comienza el dialogo, si layer es mayor que 0 se le asigna ese valor al canvas_layer

func start(layer: int = -1):
	if vacio == false:
		if layer > 0:
			canvas_layer.layer = layer
		if text_count > 0:
			inicializar_conversacion()
			canvas_layer.show()
			anim_player.play("fade_in")
		else:
			destruir()

func _process(_delta: float) -> void:
	if current_state == States.TEXTO_MOSTRADO:
		set_button_visibility(true)
		pass
	if current_state == States.MOSTRANDO_TEXTO:
		audio_stream_player.play()
	else:
		audio_stream_player.stop()

func terminar_texto():
	i = text_length
	rich_text_label.text = dialogueResource.get_dialogue_text(j)
func read_text():
	if i < text_length:
		rich_text_label.text += dialogueResource.get_dialogue_text(j)[i]
		i += 1
		timer.start()
	else:
		if current_state != States.TEXTO_MOSTRADO:
			next_text_button.disabled = false
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
			if anim_player.has_animation("fade_out"):
				anim_player.play("fade_out")
			else:
				destruir()
		
func destruir():
	dialogue_ended.emit()
	finished.emit()
	if destruirse_al_finalizar == true:
		queue_free()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		if text_count > 0:
			current_state = States.MOSTRANDO_TEXTO
			read_text()
		else:
			current_state = States.CERRANDO
			destruir()
	else:
		destruir()
		
func cambiar_a_modo_conversacion(): #resetea el cuadro de dialogo
	v_box_container.queue_free()
	
	v_box_container = VBoxContainer.new()
	v_box_container.alignment = BoxContainer.ALIGNMENT_BEGIN
	v_box_container.size_flags_vertical = v_box_container.SIZE_SHRINK_CENTER
	margin_container.add_child(v_box_container) 
	
	margin_container.move_child(v_box_container,0)
	
	
	rich_text_label = RichTextLabel.new()
	rich_text_label.scroll_active = true
	rich_text_label.fit_content = true 
	rich_text_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	rich_text_label.add_theme_font_size_override("normal_font_size",18)
	rich_text_label.custom_minimum_size = Vector2(0,52)
	v_box_container.add_child(rich_text_label)

	
		
func _on_boton_decision_pressed(indice : int):
	#TENGO QUE ELIMINAR TODOS LOS BOTONES DEL DIALOGO
	cambiar_a_modo_conversacion()
	dialogueResource = decision_actual.get_recurso_dialogo_de_decision_elegida(indice).get_recurso_dialogo_exitoso()
	if dialogueResource != null:
		canvas_layer.hide()
		start()
	else:
		current_state = States.CERRANDO
		anim_player.play("fade_out")
		destruir()
	



func _on_next_text_button_pressed() -> void:
	next_text()	
	next_text_button.disabled = true



func set_button_visibility(state:bool):
	if state == false:
		next_text_button.hide()
		next_text_button.disabled = true
		next_text_button.mouse_filter = Control.MOUSE_FILTER_IGNORE
		next_text_button.modulate = Color(1, 1, 1, 0)  # invisible por si algún estilo ignora "visible"
	else:
		next_text_button.show()
		next_text_button.disabled = false
		next_text_button.mouse_filter = Control.MOUSE_FILTER_STOP
		next_text_button.modulate = Color(1, 1, 1, 1)
