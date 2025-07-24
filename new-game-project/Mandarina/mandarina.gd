extends CharacterBody2D

signal path_end
var walking_speed := 80.0
var running_speed :=110.0
var speed := 80.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite

@onready var path_2d: Path2D = $Path2D
var waypoints: Array[Vector2] = []
var current_point := 0
var running := false



func _begin_motion():
	# Convertir Path2D a puntos globales
	for i in path_2d.curve.point_count:
		waypoints.append(path_2d.to_global(path_2d.curve.get_point_position(i)))
		
	position = waypoints[0]
	
func _physics_process(delta):
	if current_point >= waypoints.size():
		velocity = Vector2.ZERO
		path_end.emit()
	else:
		var target = waypoints[current_point]
		var direction = (target - global_position).normalized()
		velocity = direction * speed

		if global_position.distance_to(target) < 5:
			current_point += 1

		move_and_slide()
		update_animation(velocity)

func update_animation(mov: Vector2):
	if mov.length() == 0:
		animated_sprite.play("idle_right")
		return

	var action = "walk"
	var angle = mov.angle()
	var direction = ""

	if angle > -PI * 1/8 and angle <= PI * 1/8 or angle <= -PI * 7/8 or angle > PI * 7/8:
		action = "run"
		speed = running_speed 
	else: 
		action = "walk"
		speed = walking_speed

	if angle > -PI * 1/8 and angle <= PI * 1/8:
		direction = "right"
	elif angle > PI * 1/8 and angle <= PI * 3/8:
		direction = "down_right"
	elif angle > PI * 3/8 and angle <= PI * 5/8:
		direction = "down"
	elif angle > PI * 5/8 and angle <= PI * 7/8:
		direction = "down_left"
	elif angle <= -PI * 7/8 or angle > PI * 7/8:
		direction = "left"
	elif angle <= -PI * 5/8 and angle > -PI * 7/8:
		direction = "up_left"
	elif angle <= -PI * 3/8 and angle > -PI * 5/8:
		direction = "up"
	elif angle <= -PI * 1/8 and angle > -PI * 3/8:
		direction = "up_right"

	animated_sprite.play(action + "_" + direction)
	
	
	
func idle_and_look():
	animated_sprite.play("idle_right")
	await get_tree().create_timer(1.5).timeout
	path_end.emit()


func get_current_point() -> int:
	return current_point
