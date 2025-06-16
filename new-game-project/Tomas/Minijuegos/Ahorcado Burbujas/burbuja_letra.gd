extends Sprite2D

signal clicked_on

@onready var label_letra : Label = $Letra
@export var letra : String = "A"

func _ready() -> void:
	label_letra.text = letra


func _on_letra_gui_input(event: InputEvent) -> void:
	clicked_on.emit(letra)
