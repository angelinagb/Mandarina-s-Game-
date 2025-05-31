extends CanvasLayer

signal finished

@onready var nombre_quest : Label = $"PanelContainer/PanelContainer/VBoxContainer/Nombre Quest"
@onready var anim_player : AnimationPlayer = $AnimationPlayer

func set_nombre_quest(nombre):
	nombre_quest.text = nombre
	
	

func start():
	anim_player.play("fade_in_quest")
	await anim_player.animation_finished
	anim_player.play("fade_out_quest")
	await anim_player.animation_finished
	finished.emit()
	queue_free()
