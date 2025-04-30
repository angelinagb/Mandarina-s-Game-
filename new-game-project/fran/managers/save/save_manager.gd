class_name SaveManager extends Node

const SAVE_PATH := "user://world_data.ini"

# Guarda un diccionario entero en una sección del archivo
func save_dict(dict: Dictionary, section_name: String) -> void:
	var config_file := ConfigFile.new()
	
	# Intentamos cargar el archivo existente si hay algo ya guardado
	if FileAccess.file_exists(SAVE_PATH):
		config_file.load(SAVE_PATH)

	for key in dict.keys():
		config_file.set_value(section_name, str(key), dict[key])

	var error := config_file.save(SAVE_PATH)
	if error:
		print("Error al guardar en ", SAVE_PATH, ": ", error)

# Carga un diccionario desde una sección
func load_dict(section_name: String) -> Dictionary:
	var config_file := ConfigFile.new()
	var result := {}
	if FileAccess.file_exists(SAVE_PATH):
		var error := config_file.load(SAVE_PATH)
		if error != OK:
			print("Error al cargar archivo: ", error)
			return result

		for key in config_file.get_section_keys(section_name):
			result[key] = config_file.get_value(section_name, key)

	return result

# Borra un archivo si querés reiniciar
func reset_file() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		DirAccess.remove_absolute(SAVE_PATH)
