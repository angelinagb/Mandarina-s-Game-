extends CanvasLayer

signal finished


@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var titulo : Label = $Control/PanelContainer/MarginContainer/VBoxContainer/Titulo
@onready var descripcion : Label = $Control/PanelContainer/MarginContainer/VBoxContainer/Descripcion
@onready var timer : Timer = $Timer
@export var tiempo_que_aparece : float = 5.0
@onready var sound = get_node_or_null("sound")
@onready var anim_sprite = get_node_or_null("Control/AnimatedSprite2D")

func start():
	if anim_sprite:
		anim_sprite.play("appear")
	anim_player.play("fade_in")
	await anim_player.animation_finished
	
	if sound:
		sound.play()
		
	timer.start(tiempo_que_aparece)
	await timer.timeout
	
	if anim_sprite:
		anim_sprite.play("disappear")
		
		
		
	anim_player.play("fade_out")
	await anim_player.animation_finished
	
	end()

	
func end():
	#si o si al terminar tiene que lanzar la señal y autodestruirse
	finished.emit()
	queue_free()
	
func get_personalized_scene(new_description: String) -> PackedScene:
	var copy = self.duplicate()
	var label = copy.get_node("Control/PanelContainer/MarginContainer/VBoxContainer/Descripcion") as Label
	if label:
		label.text = new_description
	
	var nueva_packed_scene = PackedScene.new()
	var success = nueva_packed_scene.pack(copy)
	
	if not success:
		push_error("No se pudo empaquetar la escena personalizada")

	return nueva_packed_scene
