extends TextureButton

@export var ability_name : String
@onready var label = $Label

var level : int :
	set(value):
		level = value
		if label:
			label.text = str(level) + "/5"

func _ready() -> void:
	update_ui()

func _on_pressed() -> void:
	if SaveData.get_abilityPoints() > 0:
		SaveData.upgrade_ability(ability_name)
		update_ui()
	else:
		self.disabled = true

func update_ui():
	var ability = SaveData.get_abilities().get(ability_name)
	if ability != null:
		level = ability[0]
	else:
		level = 0

	# Este chequeo siempre después de actualizar el nivel
	if SaveData.get_abilityPoints() <= 0 or level >= 5:
		self.disabled = true
	else:
		self.disabled = false
