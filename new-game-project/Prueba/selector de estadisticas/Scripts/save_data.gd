#SCRIPT GLOBAL 
extends Node2D
const PATH = "user://player_data.cfg"

var ability_points : int = 3
var abilities: Dictionary = {
	"Cerrajeria": [0, 5],
	"Persuasión": [0, 5],
	"Animales": [0, 5],
	"Investigación": [0, 5],
	"Carisma": [0, 5]
}

@onready var config_file = ConfigFile.new()

func _ready() -> void:
	load_data() # cargo la data a la var config_file

func save_data():
	config_file.save(PATH)

#funcion para actualizar el archivo de configuracion
func set_data():
	config_file.set_value("Player","points",ability_points)
	config_file.set_value("Player","Abilities",abilities)
	
func set_and_save():
	set_data()
	save_data()

#Carga del archivo de config el objeto 
func load_data():
	if config_file.load(PATH) != OK: # si hubo algun error en el archivo de conf, seteo con los valores que tenia
		set_and_save()
	else: # cargo del archivo de configuracion los datos 
		ability_points = config_file.get_value("Player","points",3) 
		abilities = config_file.get_value("Player","Abilities",get_abilities_default())

func get_abilityPoints():
	return ability_points
	
func get_abilities():
	return abilities
	
func get_abilities_default() -> Dictionary :
	var d_abilities : Dictionary
	var d_key = [0,5]
	d_abilities["Cerrajeria"] = d_key
	d_abilities["Persuasión"] = d_key
	d_abilities["Animales"] = d_key
	d_abilities["Investigación"] = d_key
	d_abilities["Carisma"] = d_key
	return d_abilities
	
func upgrade_ability(ability_name: String) -> void:
	if(ability_name!= null and abilities.get(ability_name)!= null):
		abilities.get(ability_name)[0] += 1
		ability_points-=1
		set_and_save()
	else: 
		print("nada que hacer aqui: Habilidad "+ability_name+"Not found")
		
