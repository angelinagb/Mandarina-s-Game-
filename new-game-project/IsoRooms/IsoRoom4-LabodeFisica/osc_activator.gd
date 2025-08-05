extends Activator

const OSICLOSCOPIO = preload("res://utils/Interact/Pista/PistaPiano/osicloscopio.tscn")
# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.

func interact():
	var instance = OSICLOSCOPIO.instantiate()
	instance.process_mode = Node.PROCESS_MODE_ALWAYS
	instance.z_index = 15
	instance.show_behind_parent
	add_child(instance)
	interacted.emit(self)
	end_activable.emit()
	
