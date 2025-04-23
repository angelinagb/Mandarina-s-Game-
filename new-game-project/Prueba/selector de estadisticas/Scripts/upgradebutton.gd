extends TextureButton

@export var ability : Ability

#para que se muestre como desahabilitada
var enabled : bool = false:
	set(value):
		enabled = value
		$Panel.show_behind_parent = value
	
func _ready() -> void:
	pass

#esto es para skill tree
#func is_upgradable() -> bool:              
#	if get_index() == 0:
#		return true
#	elif get_index() > 0:
#		if get_parent().get_child(get_index() - 1).enabled == true:
#			return true
#		else:
#			return false
#	return false
	


func _on_pressed() -> void:
	if ability.can_level_up():
		if SaveData.get_abilityPoints() <= 0 :
			enabled = false
		else:
			print("No tenes puntos pa ")
			SaveData.ability_points -= 1
			ability.level_up()
			SaveData.set_and_save()
	else:
		print ("Haz alcanzo el máximo nivel de habilidad ")
		
