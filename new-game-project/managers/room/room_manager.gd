class_name RoomManager extends Node

var can_change_room: bool = true

var current: Room = null

#lol que esto sea como un start de los estados
func initialize(room_path: String):
	current = load(room_path).instantiate()
	add_child(current)
	return current

#y esto un change.to
func change_room(room_path: String) -> Room:
	if (!can_change_room):
		return
	can_change_room = false
	current.queue_free()
	current = load(room_path).instantiate()
	add_child(current)
	can_change_room = true
	return current
