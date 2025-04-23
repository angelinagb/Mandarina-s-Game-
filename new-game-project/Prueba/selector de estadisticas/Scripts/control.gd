extends Control

var player = CharacterBody2D
	

func _ready() -> void:
	player = %Player
	
func print_abilities() -> void:
	var player = get_tree().get_nodes_in_group("Player")
	var abilities = player.get_abilities()
	var carisma_label = $VBoxContainer/Label
	var persuasion_label = $VBoxContainer/Label2
	carisma_label.text = "Carisma: "+ abilities["Carisma"].level
