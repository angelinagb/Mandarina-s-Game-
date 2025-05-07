extends Control

signal ability_button_pressed(ability_name: String)

func _ready():
	pass

func update(points_available: int, abilities: Dictionary):
	$VBoxContainer/HBoxContainer/Animales_Button.update(abilities.get("Animales")[0])
	$VBoxContainer/HBoxContainer/Carisma_Button.update(abilities.get("Carisma")[0])
	$VBoxContainer/HBoxContainer/Estudio_Button.update(abilities.get("Estudio")[0])
	if points_available <= 0:
		$VBoxContainer/HBoxContainer/Animales_Button.disabled = true
		$VBoxContainer/HBoxContainer/Carisma_Button.disabled = true
		$VBoxContainer/HBoxContainer/Estudio_Button.disabled = true
		
	$VBoxContainer/AbilityPoints.text = "Tus puntos de Habiliidad: " + str(points_available)

func _on_animales_button_pressed() -> void:
	ability_button_pressed.emit("Animales")

func _on_carisma_button_pressed() -> void:
	ability_button_pressed.emit("Carisma")

func _on_estudio_button_pressed() -> void:
	ability_button_pressed.emit("Estudio")
	
