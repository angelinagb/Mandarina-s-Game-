extends Control

signal ability_button_pressed(ability_name: String)

func _ready():
	pass

func update(points_available: int, abilities: Dictionary):
	$VBoxContainer/HBoxContainer/Imagination_Button.update(abilities.get("Imaginacion")[0])
	$VBoxContainer/HBoxContainer/Carisma_Button.update(abilities.get("Carisma")[0])
	$VBoxContainer/HBoxContainer/Intelecto_Button.update(abilities.get("Estudio")[0])
	if points_available <= 0:
		$VBoxContainer/HBoxContainer/Imagination_Button.disabled = true
		$VBoxContainer/HBoxContainer/Carisma_Button.disabled = true
		$VBoxContainer/HBoxContainer/Intelecto_Button.disabled = true

	$VBoxContainer/AbilityPoints.text = "Tus puntos de Habiliidad: " + str(points_available)

func _on_carisma_button_pressed() -> void:
	ability_button_pressed.emit("Carisma")

func _on_imagination_button_pressed() -> void:
	ability_button_pressed.emit("Imaginacion")

func _on_intelecto_button_pressed() -> void:
	ability_button_pressed.emit("Estudio")
