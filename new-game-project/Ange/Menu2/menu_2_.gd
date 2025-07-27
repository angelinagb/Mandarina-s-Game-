extends MenuManager

@onready var inventory: CanvasLayer = $Inventario
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_objetcts_button_pressed() -> void:
	inventory.visible = true

func add_item_inventory(item: Dictionary):
	inventory.add_item(item)

func remove_item_inventory(item: Dictionary):
	for child in item_container.get_children():
		pass

func _ready() -> void:
	animation_player.play("fade_in")
	var item ={
			"id": "Mate",
			"name": "Mate",
			"desc": "el item 0",
			"path_img": "res://art/items/mate.png",
			"is_in_world": true,
			"is_in_player": false
	}
	add_item_inventory(item)
