extends Control

signal skill_up(skill_name: String)

func _on_upgrade_pressed() -> void:
	SaveData.upgrade_ability("Carisma")
	
func _on_upgrade_2_pressed() -> void:
	skill_up.emit($Panel/Abilities/Upgrade2.ability_name)
