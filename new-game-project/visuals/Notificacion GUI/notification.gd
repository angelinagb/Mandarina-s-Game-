extends CanvasLayer

signal finished


@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var titulo : Label = $Control/PanelContainer/MarginContainer/VBoxContainer/Titulo
@onready var descripcion : Label = $Control/PanelContainer/MarginContainer/VBoxContainer/Descripcion
@onready var timer : Timer = $Timer
@export var tiempo_que_aparece : float = 5.0
@onready var sound = get_node_or_null("sound")

func start():
	anim_player.play("fade_in")
	await anim_player.animation_finished
	if sound:
		sound.play
	timer.start(tiempo_que_aparece)
	await timer.timeout
	
	anim_player.play("fade_out")
	await anim_player.animation_finished
	
	end()

	
func end():
	#si o si al terminar tiene que lanzar la señal y autodestruirse
	finished.emit()
	queue_free()
	
