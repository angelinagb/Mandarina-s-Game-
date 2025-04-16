extends Node2D
class_name DialogueSys

signal dialogue_ended

@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var rich_text_label : RichTextLabel = $CanvasLayer/ColorRect2/MarginContainer/RichTextLabel
@onready var timer : Timer = $Timer

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
	text_count = dialogueResource.get_dialogue_count()
	if text_count > 0:
		text_length = dialogueResource.get_dialogue_text(0).length()
	i = 0
	j = 0
	timer.wait_time = dialogueResource.get_dialogue_speed()
	rich_text_label.text = ""
	current_state = States.ABRIENDO
	
	#ESTO ESTA SOLO PARA TESTEAR LA ESCENA, SE TIENE QUE COMENTAR Y LLAMAR DESDE OTRO
	#SCRIPT START PARA COMENZAR EL DIALOGO!
	# start()
	
##Comienza el dialogo, si layer es mayor que 0 se le asigna ese valor al canvas_layer
func start(layer: float = -1):
	if layer > 0:
		canvas_layer.layer = layer
	if text_count > 0:
		canvas_layer.show()
		anim_player.play("fade_in")
	else:
		##no habia texto para mostrar
		destruir()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and current_state == States.TEXTO_MOSTRADO:
		next_text()	

func terminar_texto():
	i = text_length
	rich_text_label.text = dialogueResource.get_dialogue_text(j)

func read_text():
	if i < text_length:
		##voy agregando caracteres de a uno
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
