extends Resource
class_name DecisionElementResource

@export var texto : String
@export var recurso_condicion_decision : DecisionConditionResource
@export var recurso_dialogo_exitoso : DialogueResource
@export var recurso_dialogo_fracaso : DialogueResource


func get_texto() -> String:
	return texto
	
func get_recurso_condicion() -> DecisionConditionResource:
	return recurso_condicion_decision
	
func get_recurso_dialogo_exitoso() -> DialogueResource:
	return recurso_dialogo_exitoso


func get_recurso_dialogo_fracaso() -> DialogueResource:
	return recurso_dialogo_fracaso
