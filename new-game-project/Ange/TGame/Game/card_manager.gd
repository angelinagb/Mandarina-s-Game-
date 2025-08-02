extends Node2D 
class_name CardManager

var card_scene = preload("res://Ange/TGame/Game/card.tscn")

const power_table = {
	"Espada_1": 14, "Basto_1": 13, "Espada_7": 12, "Oro_7": 11,
	"3_Espada": 10, "3_Basto": 10, "3_Copa": 10, "3_Oro": 10,
	"2_Espada": 9, "2_Basto": 9, "2_Copa": 9, "2_Oro": 9,
	"Copa_1": 8, "Oro_1": 8,
	"12_Espada": 7, "12_Basto": 7, "12_Copa": 7, "12_Oro": 7,
	"11_Espada": 6, "11_Basto": 6, "11_Copa": 6, "11_Oro": 6,
	"10_Espada": 5, "10_Basto": 5, "10_Copa": 5, "10_Oro": 5,
	"Copa_7": 4, "Basto_7": 4,
	"6_Espada": 3, "6_Basto": 3, "6_Copa": 3, "6_Oro": 3,
	"5_Espada": 2, "5_Basto": 2, "5_Copa": 2, "5_Oro": 2,
	"4_Espada": 1, "4_Basto": 1, "4_Copa": 1, "4_Oro": 1,
}

func get_power(suit: String, number: int) -> int:
	var key = "%s_%d" % [suit, number]
	return power_table.get(key, 0)


var palos = ["Espada", "Basto", "Oro", "Copa"]
var numeros_validos = [1, 2, 3, 4, 5, 6, 7, 10, 11, 12]

var deck = []

func create_deck():
	deck.clear()
	for palo in palos:
		for numero in numeros_validos:
			var card = card_scene.instantiate()
			card.init(palo, numero, get_power(palo,numero))
			deck.append(card)

func _ready() -> void:
	pass
	
func shuffle_deck():
	deck.shuffle()
	
func deal_cards() -> Array :
	var hand = []
	for i in range(3):
		var card = deck.pop_back()
		hand.append(card)
	return hand
