class_name EventManager extends Node

signal event_added(event: String)

var events: Array[String]

func initialize(events: Array[String]):
	self.events = events
	

func addEvent(event: String):
	if events.find(event) == -1:
		events.append(event)
		event_added.emit(event)

func getEvents() -> Array[String]:
	return events

func interactable_triggered(interactable_id):
	addEvent(interactable_id)
