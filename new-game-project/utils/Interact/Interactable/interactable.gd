class_name Interactable extends Node2D

signal interacted(interactable: Interactable)

@export var id: String

var my_type: String

func _ready():
	pass
	
func getId(): return id


func end(): self.queue_free()
