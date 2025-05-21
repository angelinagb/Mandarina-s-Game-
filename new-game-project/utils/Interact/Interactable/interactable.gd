class_name Interactable extends Node2D

signal interacted(interactable: Interactable)

#los id pueden ser combinacion room + tipo + orden 
@export var id: String
#para la escena que diga "Obtuviste!" 
@export var i_name : String 
@export var desc: String 

var is_in_world: bool
var is_in_player: bool

var my_type: String


func _ready(): # pass 
	$Area2D.set_monitoring(false)
	hide()
	
func getId(): return id

func start():
	$Area2D.set_monitoring(true)
	show()

func end(): self.queue_free()
