extends Node

var save_path := "user://player_data.ini"

func save_all():
	pass

func load_all():
	pass
	
# To save data
func save(item: Dictionary) -> void:
	var config_file := ConfigFile.new()
	config_file.set_value("Items", item.id, item.state)
	var error := config_file.save(save_path)
	if error:
		print("An error happened while saving data: ", error)

# To load data
func load(itemId) -> Dictionary:
	var config_file := ConfigFile.new()
	var error := config_file.load(save_path)
	if error:
		print("An error happened while loading data: ", error)
		return {}
	return config_file.get_value("Items", itemId, {})
