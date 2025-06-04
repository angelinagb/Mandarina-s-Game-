extends Interactable 

@onready var wave: Node2D = $Wave
@onready var begin_button: Button = $BeginButton
@onready var close_button: Button = $CloseButton
@onready var label: Label = $Label

signal finished 

var secuence = ["E5", "D5", "C5", "A4", "B4", "D5", "C5","B4","G#4","A4"]

func ready():
	my_type = "activator"
	super._ready()


#func _on_wave_playing(value: bool) -> void: # cuando me llegue la signal de que termino? 
	#if not value:
		#button.toggled.emit(false)
		#wave.is_playing = false
		##clean 


	
func play_secuence():
	for key in secuence:
		var hz = wave.frecuency_notes.get(key, 0.0)
		label.text = "%s — %.2f Hz" % [key, hz]
		#label.text = "%.2f hz" %hz
		wave.play_note(key)
		await wave.playing 
	wave.stop()
	begin_button.disabled = false
	label.text = "Secuence ended"


func _on_begin_pressed() -> void:
	play_secuence()
	begin_button.disabled = true

func _on_close_pressed() -> void:
	finished.emit()
	queue_free()

func start():
	pass
	
