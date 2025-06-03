class_name RoomManager extends Node

var can_change_room: bool = true

var current: IsoRoom = null

var rooms = {
	"ROOM-4":"res://IsoRooms/IsoRoom1/1_iso_room.tscn" ,
	"ROOM-4-II": "res://IsoRooms/IsoRoom1/1b_iso_room.tscn",
	"ROOM-5": "res://IsoRooms/IsoRoom2/2_iso_room_cafeteria.tscn",
	"ROOM-6": "res://IsoRooms/IsoRoom3-LabodeQuimica/3_iso_room.tscn"
}

func get_room(room_id : String) -> String:
	return rooms[room_id]

func update_room(room_id : String, new_room_version : String):
	rooms[room_id] = new_room_version


func initialize(room_path: String):
	current = load(room_path).instantiate()
	add_child(current)
	return current

func change_room(room_id: String) -> IsoRoom:
	if (!can_change_room):
		return
	can_change_room = false
	current.queue_free()
	current = load(get_room(room_id)).instantiate()
	add_child(current)
	can_change_room = true
	return current

func _ready() -> void:
	pass
