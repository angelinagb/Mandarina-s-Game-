extends Control

signal rotated

@export var tipo: String

var rotacion_actual = 0
var conexiones_por_rotacion := []

@onready var sprite: TextureRect = $TextureRect

func _ready():
	configurar_conexiones()
	update_visual()
	centrar_pivote()

func centrar_pivote():
	await get_tree().process_frame  # Espera un frame para asegurar que rect_size está disponible
	sprite.set_anchors_preset(Control.PRESET_CENTER)
	sprite.pivot_offset = sprite.size / 2

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if tipo in ["base", "inicio", "final"]:
			return  # No rotar piezas fijas
		rotacion_actual = (rotacion_actual + 1) % conexiones_por_rotacion.size()
		update_visual()
		emit_signal("rotated")

func configurar_conexiones():
	match tipo:
		"linea":
			conexiones_por_rotacion = [
				["left", "right"],  # rotación 0: horizontal
				["up", "down"]      # rotación 90: vertical
			]
		"codo":
			conexiones_por_rotacion = [
				["left", "down"],
				["up", "left"],
				["right", "up"],
				["down", "right"]
				
			]
		"cruz":
			conexiones_por_rotacion = [
				["up", "right", "down", "left"]  # no rota
			]
		"t":
			conexiones_por_rotacion = [
				["down", "left", "right"],    # rotación 0 (T hacia arriba)
				["left", "up", "down"],    # rotación 90 (T hacia derecha)
				["up", "left", "right"],  # rotación 180 (T hacia abajo)
				["right", "up", "down"]      # rotación 270 (T hacia izquierda)
			]
		"inicio":
			conexiones_por_rotacion = [["right"]]  # fijo
		"final":
			conexiones_por_rotacion = [["left"]]   # fijo
		"base":
			conexiones_por_rotacion = [[]]         # sin conexiones

func update_visual():
	sprite.rotation_degrees = rotacion_actual * 90

func get_conexiones():
	var conexiones
	if tipo in ["inicio", "final", "base"]:
		conexiones = conexiones_por_rotacion[0]
	else:
		conexiones = conexiones_por_rotacion[rotacion_actual % conexiones_por_rotacion.size()]
	return conexiones
