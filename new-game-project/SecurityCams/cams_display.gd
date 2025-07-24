extends CanvasLayer

const SECURITY_CAMS_1 = preload("res://SecurityCams/security_cams1.tscn")
const SECURITY_CAMS_2 = preload("res://SecurityCams/security_cams2.tscn")
const SECURITY_CAMS_3 = preload("res://SecurityCams/security_cams3.tscn")
const SECURITY_CAMS_4 = preload("res://SecurityCams/security_cams4.tscn")
@onready var container: CenterContainer = $Container

var current_cam = 1
signal finished

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	display(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func display(camera_numer : int ):
	var camera_scene: PackedScene
	match camera_numer:
		1: camera_scene = SECURITY_CAMS_1
		2: camera_scene = SECURITY_CAMS_2
		3: camera_scene = SECURITY_CAMS_3
		4: camera_scene = SECURITY_CAMS_4
		_: return
	
	# Eliminar lo anterior (si hay algo)
	for child in container.get_children():
		container.remove_child(child)
		child.queue_free()
	
	# Instanciar y agregar la nueva
	var camera_instance = camera_scene.instantiate()
	container.add_child(camera_instance)

func _on_prev_pressed() -> void:
	if current_cam == 1: 
		current_cam = 4
	else:		current_cam -= 1
	
	display(current_cam)
		


func _on_next_pressed() -> void:
	if current_cam == 4: 
		current_cam = 1
	else:
		current_cam += 1
	
	display(current_cam)
	
func start():
	process_mode = Node.PROCESS_MODE_ALWAYS
	display(1)


func _on_exit_pressed() -> void:
	finished.emit()
	queue_free()
