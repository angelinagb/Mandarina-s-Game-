#✅ Escucha cuando se presiona una tecla.
#✅ Compara esa tecla con una secuencia.
#✅ Detecta si se equivocó y reinicia.
#✅ Avanza si acierta.
#✅ Emite señal de victoria si completa la secuencia

extends Node2D

signal on_puzzle_solved(Reward: String)

@onready var h_box_container: HBoxContainer = $HBoxContainer
@onready var feedback_player: AudioStreamPlayer2D = $feedbackPlayer
@onready var canvas_modulate: CanvasModulate = $CanvasModulate
@onready var camera_2d: Camera2D = $Camera2D


var win_sound = preload("res://utils/Interact/Puzzle/PianoPuzzle/Sounds/sound_effects/win.wav")
var error_sound = preload("res://utils/Interact/Puzzle/PianoPuzzle/Sounds/sound_effects/error.wav")

var target_sequence: Array[String] = ["F5#", "B4", "C5#", "D5", "E5", "F5#", "D5","F5#","D5","F5#","B4","D5","B4","G4","D5","B4"]

var current_index := 0

func _ready():
#	await get_tree().process_frame
	for key in get_tree().get_nodes_in_group("piano_keys"):
		key.connect("key_pressed", Callable(self, "_on_key_pressed"))

func _on_key_pressed(note: String) -> void:
	if note.to_upper() == target_sequence[current_index]:
		print("✅ Correcto:", note)
		current_index += 1
		if current_index >= target_sequence.size():
			feedback_win()
			print("🎉 ¡Secuencia completada!")
			on_puzzle_solved.emit("Chocolate")
			current_index = 0  # o podés cambiar de nivel
	else:
		print("❌ Error. Esperaba:", target_sequence[current_index])
		feedback_error()
		current_index = 0  # reset
	

func feedback_error():
	canvas_modulate.color = "902318"
	play_feedback_sound("error")
	await get_tree().create_timer(0.5).timeout
	print("restarting secuence")
	canvas_modulate.color ="ffffff"
	

func feedback_win():
	canvas_modulate.color = "76ff6d"
	play_feedback_sound("win")
	await get_tree().create_timer(2.02).timeout
	

func play_feedback_sound(type: String):
	if feedback_player.playing:
		feedback_player.stop()

	match type:
		"win":
			feedback_player.stream = win_sound
		"error":
			feedback_player.stream = error_sound

	feedback_player.play()

func hidep():
	self.hide()
	for key in get_tree().get_nodes_in_group("piano_keys"):
		key.disable = true 
	
func showp():
	self.show() 
	self.show_behind_parent= true
	#for key in get_tree().get_nodes_in_group("piano_keys"):
		#key.disable = false 
	camera_2d.make_current()
