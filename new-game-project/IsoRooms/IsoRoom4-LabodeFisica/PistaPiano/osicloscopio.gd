extends Node 

@onready var wave: Node2D = $Wave
@onready var button: Button = $Button
@onready var label: Label = $Label


var secuence = ["E5", "D5", "C5", "A4", "B4", "D5", "C5","B4","G#4","A4"]

func ready():
	pass


#func _on_wave_playing(value: bool) -> void: # cuando me llegue la signal de que termino? 
	#if not value:
		#button.toggled.emit(false)
		#wave.is_playing = false
		##clean 


func _on_button_toggled(toggled_on: bool) -> void:
	play_secuence()
	button.disabled = true
	
func play_secuence():
	for key in secuence:
		var hz = wave.frecuency_notes.get(key, 0.0)
		label.text = "%s — %.2f Hz" % [key, hz]
		#label.text = "%.2f hz" %hz
		wave.play_note(key)
		await wave.playing 
	wave.stop()
	button.disabled = false
	label.text = "Secuence ended"
