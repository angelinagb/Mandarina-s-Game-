class_name InventoryManager
extends Node

var items: Dictionary = {}
var items_in_world: Array[String]
var items_in_player: Array[String]

signal item_updated(item: Dictionary)

func initialize(items: Dictionary) -> void:
	self.items = items
	for child in items:
		if items[child].is_in_world:
			items_in_world.append(child)
		elif items[child].is_in_player:
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
	if items_in_world.has(item_id):
		items[item_id].is_in_world = false
		items[item_id].is_in_player = true
		items_in_world.erase(item_id)
		items_in_player.append(item_id)
		item_updated.emit(items[item_id])

func item_used(item_id: String) -> void:
	if items_in_player.has(item_id):
		items[item_id].is_in_player = false
		items_in_player.erase(item_id)
		item_updated.emit(items[item_id])

func is_item_in_world(item_id: String) -> bool:
	return items_in_world.has(item_id)

func is_item_in_player(item_id: String) -> bool:
	return items_in_player.has(item_id)
