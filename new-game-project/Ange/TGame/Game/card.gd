extends Control
class_name Card

signal selected(card: Card)

var card_number: int
var palo: String # 1 Oro 2 Copa 3 Espada 4 Basto
var power : int

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var back: TextureRect = $Back

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(card_number)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func init(palo_: String, numero_: int, poder: int):
	palo = palo_
	card_number = numero_
	var ruta = "res://Ange/TGame/Assets/spanish_deck/%d%s.PNG" % [card_number, palo]
	$CardImage.texture = load(ruta)
	
	

	


func _on_button_pressed() -> void:
	if back.z_index >= 0 :
		back.z_index = -1
	else:
		print("play")
		selected.emit(self)
		
