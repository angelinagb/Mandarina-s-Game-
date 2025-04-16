extends Node

var items_in_world: Dictionary
var items_in_player: Dictionary

func _ready():
	pass

func initialize_inventory(items_in_world: Dictionary, items_in_player: Dictionary):
	self.items_in_world = items_in_world
	self.items_in_player = items_in_player

func item_grabbed(id_key: int):
	items_in_world.get(id_key).grabbed = true

func item_used(id_key: int):
	items_in_player.get(id_key).used = true
	
# items {
# id
# texto_encuentro
# descripcion
# ruta imagen || posicion imagen (depende implementacion)
# agarrado || usado (depende lista)
#}
