extends CanvasLayer

var next_slot := 0

@onready var slots := [
	$Control/Control/GridContainer/Slot0,
	$Control/Control/GridContainer/Slot1,
	$Control/Control/GridContainer/Slot2,
	$Control/Control/GridContainer/Slot3,
	$Control/Control/GridContainer/Slot4,
	$Control/Control/GridContainer/Slot5,
	$Control/Control/GridContainer/Slot6,
	$Control/Control/GridContainer/Slot7,
	$Control/Control/GridContainer/Slot8,
	$Control/Control/GridContainer/Slot9,
	$Control/Control/GridContainer/Slot10,
	$Control/Control/GridContainer/Slot11
]

@onready var object_name: Label = $VBoxContainer/Object_Name
@onready var description: RichTextLabel = %Description

var items_in_player: Array[Dictionary] = []

func add_item(item: Dictionary) -> void:
	if item != null and next_slot < slots.size():
		slots[next_slot].icon = load(item.path_img)
		# slots[next_slot].expand_icon = true

		# Asegurar que el array tenga la longitud adecuada
		while items_in_player.size() <= next_slot:
			items_in_player.append(null)

		items_in_player[next_slot] = item
		next_slot += 1

func _on_button_pressed(extra_arg_0: int) -> void:
	if extra_arg_0 >= 0 and extra_arg_0 < items_in_player.size():
		var selected_item = items_in_player[extra_arg_0]
		if selected_item != null:
			object_name.text = selected_item.name
			description.text = selected_item.desc
			object_name.visible = true
			description.visible = true
			return
	
	# Si el ítem está vacío o el índice no existe
	object_name.visible = false
	description.visible = false

func _on_back_button_pressed() -> void:
	queue_free()
