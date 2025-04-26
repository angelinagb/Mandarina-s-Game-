extends Node2D
const PATH = "user://player_data.cfg"

var ability_points =  3
var abilities: Dictionary

@onready var config = ConfigFile.new()

func _ready() -> void:
	load_data()

func save_data():
	config.save(PATH)

func set_data():
	config.set_value("Player","points",ability_points)
	config.set_value("Player","Abilities",set_abilities_default())
	
func set_and_save():
	set_data()
	save_data()

func load_data():
	if config.load(PATH) != OK:
		set_and_save()
	else:
		ability_points = config.get_value("Player","points",3)
		abilities = config.get_value("Player","Abilities",set_abilities_default())

func get_abilityPoints():
	return ability_points
	
func get_abilities():
	return abilities
	
func set_abilities_default() -> Dictionary :
	var d_abilities : Dictionary
	d_abilities["Cerrajeria"] = [0,5]
	d_abilities["Persuasión"] = [0,5]
	d_abilities["Animales"] = [0,5]
	d_abilities["Investigación"] = [0,5] 
	d_abilities["Carisma"] = [0,5]
	return d_abilities
	
func upgrade_ability(ability_name: String) -> void:
	abilities.get(ability_name)[0] += 1
	print(abilities[ability_name][0])
	set_and_save()
