class_name DialogueManager
extends Node

@onready var text_label = $CanvasLayer/Control/RichTextLabel
@onready var canvas = $CanvasLayer
@onready var showing_text := false

func initialize():
	pass

func _ready():
	canvas.hide()

func start_dialogue(text: String) -> void:
	canvas.show()
	text_label.show()
	text_label.text = text
	showing_text = true

	await get_tree().create_timer(5).timeout

	text_label.text = ""
	text_label.hide()
	canvas.hide()
