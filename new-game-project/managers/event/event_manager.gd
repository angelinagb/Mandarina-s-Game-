class_name EventManager extends Node

signal event_added(event: String)

var events: Array[String]
var inventory_manager: InventoryManager
func initialize(inventory_manager: InventoryManager, events: Array[String]):
	self.inventory_manager = inventory_manager
	inventory_manager.item_updated.connect(on_item_updated)
	
	self.events = events
	

func addEvent(event: String):
	if events.find(event) == -1:
		events.append(event)
		event_added.emit(event)

func getEvents() -> Array[String]:
	return events

func on_item_updated(item: Dictionary):
	addEvent(item.id)
