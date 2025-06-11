extends CanvasLayer

signal button_open_menu_pressed

@onready var control: Control = $Control
@onready var interact_button: Button = $Control/InteractButton


func _on_button_pressed() -> void:
	button_open_menu_pressed.emit()

#func showbehind():
	#control.mouse_filter = Control.MOUSE_FILTER_IGNORE
func _ready():
	InteractionManager.connect("interactuable_cambiado", _on_interactuable_cambiado)
	

func _on_interactuable_cambiado(i):
	var button_text = "interact"
	interact_button.disabled = i == null
	if (i) and i.has_method("get_type"):
		var type = i.get_type()
		print(type)
		 #default
		match type:
			"item"			: button_text = "pick up"
			"npc"			: button_text = "talk"
			"transitioner"	: button_text = "to-room"
			"activator"		: button_text = "use"

		interact_button.text = button_text
	
func _on_interact_button_pressed() -> void:
	InteractionManager.interact()


func _on_check_button_pressed() -> void:
	pass
