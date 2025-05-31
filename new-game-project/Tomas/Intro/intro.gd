extends Node2D

signal finished

@onready var dialogo_sistema : DialogueSystem = $"Dialogue System"

@export var dialogo_1 : Dialogo

func start():
	dialogo_sistema.dialogueResource = dialogo_1
	dialogo_sistema.start()
	await dialogo_sistema.finished
	finished.emit()
