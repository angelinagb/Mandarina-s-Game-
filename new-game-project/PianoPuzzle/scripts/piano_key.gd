
""" LA COLISION SHAPE ESTA PARA GUIARNOS CON LOS TAMAÑOS NO LA SAQUEN :)  """

class_name PianoKey extends TextureButton

@export var is_black: bool = false
@export var note: String = ""
@export var stream: AudioStream

@onready var stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var tween := get_tree().create_tween()
@onready var label: Label = $Label

signal key_pressed(note: String)

var whiteoff = preload("res://PianoPuzzle/sprites/whiteunpressed.png")
var whiteon = preload("res://PianoPuzzle/sprites/whitepressed.png")
var blackoff = preload("res://PianoPuzzle/sprites/blackunpressed.png")
var blackon = preload("res://PianoPuzzle/sprites/blackpressed.png")

func _ready() -> void:
	label.text = note
	add_to_group("piano_keys")
	#update_sprite(true)
	if stream == null:
		push_warning("⚠️ El stream de audio no está asignado para la nota %s" % note)
	else:
		stream_player.stream = stream
	texture_normal = blackoff if is_black else whiteoff
	texture_pressed = blackon if is_black else whiteon


func _on_button_down() -> void:
	stream_player.volume_db= 0 
	stream_player.play()
	emit_signal("key_pressed", note)

func _on_button_up() -> void:
	await get_tree().create_timer(0.5).timeout
	fade_out()
	stream_player.stop()

func fade_out():
	tween.tween_property(stream_player,"volume_db",-80,1.0)
