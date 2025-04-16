class_name Player2
extends CharacterBody2D

const MOTION_SPEED = 160 # Pixels/second.
var _destination = Vector2()
var path = []

var current: Room 

func _ready():
	z_index = 1
	
func setCurrent(current: Room):
	self.current = current
	
func _process(_delta):
	#if(path != []):
	#	var next_pos_move = current.getTileMapLayer().map_to_local(path.pop_front())
	#	print(next_pos_move)
		# var motion = Vector2(next_pos_move[0] - position.x, next_pos_move[1] - position.y)
		# velocity = motion.normalized() * MOTION_SPEED
	#	position = next_pos_move
	#	await get_tree().create_timer(1.0).timeout
	#else:
		# velocity = Vector2.ZERO
	#	pass
	#move_and_slide()
	pass

func _unhandled_input(event):
	if event.is_action_pressed("mover"):
		build_path()

func build_path():
	var mouse_pos = get_global_mouse_position()
	var start_pos = position
	var local_mouse_pos = current.getTileMapLayer().local_to_map(mouse_pos)
	var local_start_pos = current.getTileMapLayer().local_to_map(start_pos)
	
	var mouse_tile_pos = local_mouse_pos
	var start_tile_pos = local_start_pos
	
	var next_pos = start_tile_pos
	while (next_pos[0] != mouse_tile_pos[0] or next_pos[1] != mouse_tile_pos[1]):
		if(next_pos[0] > mouse_tile_pos[0]):
			next_pos = Vector2(next_pos[0]-1, next_pos[1])
		elif(next_pos[0] < mouse_tile_pos[0]):
			next_pos = Vector2(next_pos[0]+1, next_pos[1])
		elif(next_pos[1] > mouse_tile_pos[1]):
			next_pos = Vector2(next_pos[0], next_pos[1]-1)
		elif(next_pos[1] < mouse_tile_pos[1]):
			next_pos = Vector2(next_pos[0], next_pos[1]+1)
		path.append(next_pos)
	while(path != []):
		var next_pos_move = current.getTileMapLayer().map_to_local(path.pop_front())			
		position = next_pos_move
		await get_tree().create_timer(1.0).timeout
