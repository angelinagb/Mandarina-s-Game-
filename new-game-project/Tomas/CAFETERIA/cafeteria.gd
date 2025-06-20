extends IsoRoom

@export var dialogo_intro : PackedScene
@onready var anim_player : AnimationPlayer = $CinematicasCafeteria
@export var minijuego : PackedScene

func _ready() -> void:
	super._ready()
	await intro()
	
func intro():
	QueueManager.enqueue_event(minijuego)
	await QueueManager.finished
	player_b.esconder_joystick()
	anim_player.play("fade_out")
	await anim_player.animation_finished
	QueueManager.enqueue_event(dialogo_intro)
	await QueueManager.finished
	player_b.mostrar_joystick()
	#anim_player.play("intro")
	#await anim_player.animation_finished


func _on_vendedor_q_1_quest_begun() -> void:
	#Empieza Quest 1, habilito los grupos para interactuar
	for node : Node in get_tree().get_nodes_in_group("Q1_GRUPOS"):
		node.process_mode = Node.PROCESS_MODE_INHERIT
