extends TextureButton

func _ready() -> void:
	pass
	
func update(ability_points: int) -> void:
	$Label.text = str(ability_points) + "/5"
	if ability_points >= 5:
		self.disabled = true
	else:
		self.disabled = false
