
#Wave
extends Node2D

signal playing(value: bool) # cuando se esta dibujando

const AMPLITUDE = 50.0
const DURATION = 2.0  # segundos
const ESCALA_X = 0.00015

var phase := 0.0
var timer := 0.0
var is_playing := false #la onda actual

var frequency := 440.0
var note_name := ""

var font := preload("res://art/Fonts/Audiowide-Regular.ttf")

var frecuency_notes = {
	"E5": 659.25,
	"D5": 587.33,
	"C5": 523.25,
	"A4": 440.00,
	"B4": 493.88,
	"G#4": 415.30
}

var note_colors = []

#ajustes 
func _ready():
	# Asignar colores únicos por nota (HSV escalado según índice)
	var count = frecuency_notes.size()
	for i in range(count):
		note_colors.append(Color.from_hsv(float(i)/count, 0.8, 0.9))

#control
func _process(delta):
	if not is_playing:
		return
	
	phase += delta * 2.0
	timer += delta 
	
	if timer >= DURATION:
		is_playing = false
		playing.emit(false)
		return
		
	queue_redraw()

func _draw():
	if not is_playing:
		return 
	
	var viewport_size = get_viewport().get_visible_rect().size
	var length = viewport_size.x
	var y_center = viewport_size.y / 2
	var note_keys = frecuency_notes.keys()
	var idx = note_keys.find(note_name)
	var color = Color.TRANSPARENT
	
	color = note_colors[idx]
	var prev_point = Vector2(0, sin(0 * frequency * ESCALA_X + phase) * AMPLITUDE + y_center) #f(0,0) 
	
	for x in range(1, int(length)):
	#	var y = sin(x * frequency * ESCALA_X + phase) * AMPLITUDE + y_center
		var x_scaled = x * frequency * ESCALA_X
		var y = sin(x_scaled + phase) * AMPLITUDE + y_center
		var wavelength = 1.0 / frequency # Periodo
		#var y = sin((x * ESCALA_X + phase) / wavelength * TAU) * AMPLITUDE + y_center

		var point = Vector2(x, y)
		draw_line(prev_point, point, color, 2.0)
		prev_point = point
	

func play_note(note: String):
	if not frecuency_notes.has(note):
		push_warning("Nota no válida: %s" % note)
		return
	
	note_name = note
	frequency = frecuency_notes[note]
	phase = 0.0
	timer = 0.0
	
	is_playing = true
	playing.emit(true) # aviso que empieza 
	print("playing: " + note)


func stop():
	is_playing = false
	note_name = ""
	queue_redraw()
