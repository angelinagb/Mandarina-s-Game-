extends IsoRoom

@export var dialogo_intro : PackedScene
@onready var anim_player : AnimationPlayer = $CinematicasCafeteria

func _ready() -> void:
	super._ready()
	#intro
	await intro()
	print("Termino la intro")
	
func intro():
	player_b.esconder_joystick()
	anim_player.play("fade_out")
	await anim_player.animation_finished
	QueueManager.enqueue_event(dialogo_intro)
	await QueueManager.finished
	player_b.mostrar_joystick()
	#anim_player.play("intro")
	#await anim_player.animation_finished
