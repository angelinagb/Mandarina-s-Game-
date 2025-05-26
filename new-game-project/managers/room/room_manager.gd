class_name RoomManager extends Node

var can_change_room: bool = true

var current: Room = null

var rooms = {
	"ROOM-4": "res://rooms/Instancias/room_4.tscn",
	"ROOM-5": "res://rooms/Instancias/room_5.tscn",
	"ROOM-6": "res://rooms/Instancias/room_6.tscn"
}

func get_room(room_id : String) -> String:
	return rooms[room_id]

func update_room(room_id : String, new_room_version : String):
	rooms[room_id] = new_room_version


func initialize(room_path: String):
	current = load(room_path).instantiate()
	add_child(current)
	return current

func change_room(room_id: String) -> Room:
	if (!can_change_room):
		return
	can_change_room = false
	current.queue_free()
	current = load(get_room(room_id)).instantiate()
	add_child(current)
	can_change_room = true
	return current
