class_name InventoryManager
extends Node

var items: Dictionary = {}
var items_in_world: Array[String]
var items_in_player: Array[String]
var keys_in_player: Array[String]

signal game_ended()
signal item_updated(item: Dictionary)

var cont: int = 0

func initialize(Items: Dictionary) -> void:
	self.items = Items
	for child in Items:
		if Items[child].is_in_world:
			items_in_world.append(child)
		elif Items[child].is_in_player:
			items_in_player.append(child)

func get_items() -> Dictionary:
	return items

func get_item_data(item_id: String):
	return items[item_id]

func get_items_in_world() -> Array[String]:
	return items_in_world

func get_items_in_player() -> Array[String]:
	return items_in_player

func item_grabbed(item_id: String) -> void:
	if not items_in_world.has(item_id):
		return
	else :
		items[item_id].is_in_world = false
		items[item_id].is_in_player = true
		items_in_world.erase(item_id)
		give_item_to_player(item_id)

func item_used(item_id: String) -> void:
	if items_in_player.has(item_id):
		items[item_id].is_in_player = false
		items_in_player.erase(item_id)
		item_updated.emit(items[item_id])

func is_item_in_world(item_id: String) -> bool:
	return items_in_world.has(item_id)

func is_item_in_player(item_id: String) -> bool:
	return items_in_player.has(item_id)
	
func give_item_to_player(item_id: String) -> void:
		items[item_id].is_in_world = false
		items[item_id].is_in_player = true
		items_in_player.append(item_id)
		item_updated.emit(items[item_id])
		if item_id == "Capitulo1" or item_id == "Capitulo2" or item_id == "Capitulo3" or item_id == "Capitulo4":
			cont += 1
		if cont == 4:
			game_ended.emit()

func new_key(key : String):
	keys_in_player.append(key)

func has_key(room_id : String):
	for key in keys_in_player:
		if key == room_id:
			return true
	return false
