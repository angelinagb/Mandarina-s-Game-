extends CanvasLayer
class_name burbuja_letra

signal clicked_on

@onready var label_letra : Label = $PanelContainer/Letra
@onready var timer : Timer = $Timer
@onready var panel : PanelContainer = $PanelContainer
var speed : float = 20
var hacia_derecha : bool

func initialize(letra : String, mueve_hacia_derecha : bool, velocidad : float):
	speed = velocidad 
	hacia_derecha = mueve_hacia_derecha
	label_letra.text = letra.to_upper()
	timer.start(4)
	var screen_height = get_viewport().size.y
	var posibles_spawns = [screen_height * 0.35, screen_height * 0.65]
	if mueve_hacia_derecha:
		panel.set_position(Vector2(0, posibles_spawns[randi()% 2]))
	else:
		panel.set_position(Vector2(get_viewport().size.x, screen_height * 0.5))
	process_mode = Node.PROCESS_MODE_INHERIT
	
func _process(delta: float) -> void:
	if hacia_derecha == true:
		panel.set_position(Vector2(panel.get_screen_position().x + speed * delta, panel.get_screen_position().y))
	else:
		panel.set_position(Vector2(panel.get_screen_position().x - speed * delta, panel.get_screen_position().y))


func _on_letra_gui_input(event: InputEvent) -> void:
	clicked_on.emit(label_letra.text)
	queue_free()


func _on_timer_timeout() -> void:
	queue_free()
