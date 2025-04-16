extends Node

@export var rooms: Array[PackedScene]

signal changed_current_room
signal item_grabbed(itemId)
signal dialogue_ended

var can_change_room: bool = true

var current: Room = null

var loaded_rooms = {
	0: null,
	1: null,
	2: null
}

var storage_position: Vector2 = Vector2(1024, 1024)

var show_position: Vector2 = Vector2.ZERO

func _ready():
	pass

func is_loaded(room_id: int):
	if (loaded_rooms[room_id] != null):
		return true
	return false
	
func load_room(room_id: int):
	var new_room: Node = rooms[room_id].instantiate()
	new_room.changed_room.connect(on_changed_room.bind())
	new_room.item_grabbed.connect(on_item_grabbed.bind())
	new_room.dialogue_ended.connect(on_dialogue_ended.bind())
	loaded_rooms[room_id] = new_room
	add_child(new_room)
	move_out(new_room)
	
func unload_room(room_id: int):
	loaded_rooms[room_id].queue_free()
	loaded_rooms[room_id] = null

func get_current():
	return current

func set_current(room_id: int):
	if current != null:
		move_out(current)
	current = loaded_rooms[room_id]
	move_in(current)
	check_loads()
	check_unloads()
	
func check_loads():
	for child in current.get_adjacent():
		if !is_loaded(child):
			load_room(child)

func check_unloads():
	var should_exist: bool
	for key in loaded_rooms:
		if (current != loaded_rooms[key]):
			should_exist = false
			if(loaded_rooms[key] != null):
				for child in current.get_adjacent():
					if(key == child):
						should_exist = true
				if !should_exist:
					unload_room(key)

func move_out(target_room: Node):
	target_room.position = storage_position

func move_in(target_room: Node):
	target_room.position = show_position

func on_changed_room(destiny: int):
	if (!can_change_room):
		return
	can_change_room = false
	set_current(destiny)
	changed_current_room.emit()
	await get_tree().create_timer(1.0).timeout
	can_change_room = true

func set_current_2(room: PackedScene):
	if current != null:
		current.queue_free()
	current = room.instantiate()
	current.changed_room.connect(on_changed_room_2.bind())
	current.item_grabbed.connect(on_item_grabbed.bind())
	current.dialogue_ended.connect(on_dialogue_ended.bind())
	
	add_child(current)

func on_changed_room_2(room: PackedScene):
	if (!can_change_room):
		return
	can_change_room = false
	var previous_room = current.getMyName()
	set_current_2(room)
	changed_current_room.emit(previous_room)
	await get_tree().create_timer(1.0).timeout
	can_change_room = true

func on_item_grabbed(itemId: int):
	item_grabbed.emit(itemId)

func on_dialogue_ended():
	dialogue_ended.emit()
