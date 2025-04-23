extends Node2D

var ability_points =  3
var ability_list = []
const PATH = "user://player_data.cfg"

@onready var config = ConfigFile.new()

func _ready() -> void:
	load_data()

func save_data():
	config.save(PATH)

func set_data():
	config.set_value("Player","points",ability_points)
	config.set_value("Player","ability_list",ability_list)
func set_and_save():
	set_data()
	save_data()

func load_data():
	if config.load(PATH) != OK:
		set_and_save()
		
	ability_points = config.get_value("Player","points",3)
	ability_list = config.get_value("Player","ability_list",[])

func get_abilityPoints():
	return ability_points
	
