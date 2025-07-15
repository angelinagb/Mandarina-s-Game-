extends Resource
class_name Opcion


@export var texto : String
@export var condicion : Condicion
@export var dialogo_exitoso : Dialogo
@export var array_eventos : Array[Evento]
@export var dialogo_fracaso : Dialogo
@export_enum("Chat","Quit","Quest") var decision_type = "Chat"

func get_texto() -> String:
	return texto
	
func get_recurso_condicion() -> Condicion:
	return condicion
	
func get_recurso_dialogo_exitoso() -> Dialogo:
	return dialogo_exitoso

func get_recurso_dialogo_fracaso() -> Dialogo:
	return dialogo_fracaso

func get_type() -> String:
	return decision_type
