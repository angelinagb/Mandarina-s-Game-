class_name RoomManager extends Node

var can_change_room: bool = true

var current: IsoRoom = null

var rooms = {
	"ROOM-4":"res://IsoRooms/IsoRoom1/1_iso_room.tscn" ,
	"ROOM-4-II": "res://IsoRooms/IsoRoom1/1b_iso_room.tscn",
	"ROOM-5": "res://Tomas/CAFETERIA/CAFETERIA_CON_CONTENIDO.tscn",
	"ROOM-6": "res://IsoRooms/IsoRoom3-LabodeQuimica/3_iso_room.tscn",
	"ROOM-PASILLO1": "res://Franco/Franco/rooms/pasillo1/pasillo_1.tscn",
	"ROOM-ENTRADA": "res://Franco/Franco/rooms/Entrada/entrada_iso_room.tscn",
	"ROOM-LABOFISICA": "res://IsoRooms/IsoRoom4-LabodeFisica/4_iso_room_labodefisica.tscn",
	"ROOM-CENTROALUMNOS":"res://Franco/Franco/rooms/Centro alumnos/centro_alumnos.tscn",
	"ROOM-PASILLO2": "res://Franco/Franco/rooms/pasillo2/pasillo_2.tscn",
	"ROOM-SALACOMUN":"res://Franco/Franco/rooms/SalaComun/sala_comun.tscn",
	"ROOM-LABOSYH":"res://Ange/labo_sy_h_iso_room.tscn"
	}

func get_room(room_id : String) -> String:
	return rooms[room_id]

func update_room(room_id : String, new_room_version : String):
	rooms[room_id] = new_room_version
	StateManager.save_room_state(room_id, {}) #al cambiar de version de room, no hay estado distinto al que viene con la room


func initialize(room_path: String):
	current = load(room_path).instantiate()
	add_child(current)
	return current

func change_room(room_id: String) -> IsoRoom:
	if (!can_change_room):
		return
	can_change_room = false
	current.save_state()
	current.queue_free()
	current = load(get_room(room_id)).instantiate()
	add_child(current)
	can_change_room = true
	return current

func _ready() -> void:
	StateManager.inicializar_rooms(rooms.keys())
