extends Label

func _process(delta: float) -> void:
	text = "Tus puntos de Habiliidad: " + str(SaveData.get_abilityPoints())
