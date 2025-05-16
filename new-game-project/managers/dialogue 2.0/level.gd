extends Node2D


@onready var a : DialogueSystem = $"Dialogue System"

func _ready() -> void:
	a.start()
