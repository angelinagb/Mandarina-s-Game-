class_name GuiManager extends CanvasLayer

@onready var vbox := $Control/VBoxContainer

@onready var vbox2 := $Control/VBoxContainer2

var quest_manager: QuestManager
var inventory_manager: InventoryManager

func initialize(quest_manager: QuestManager, inventory_manager: InventoryManager, items: Dictionary, quests: Array[Quest]):
	self.quest_manager = quest_manager
	quest_manager.quest_updated.connect(on_quest_updated)
	
	self.inventory_manager = inventory_manager
	inventory_manager.item_updated.connect(on_item_updated)
	
	for item in items:
		if items[item].is_in_player and not items[item].is_in_world:
			add_item_inventory(items[item])
	for quest in quests:
		if not quest.is_completed():
			add_quest_ui(quest)


func add_item_inventory(item: Dictionary):

	# Nodo contenedor para imagen + texto
	var hbox := HBoxContainer.new()
	
	# Imagen del ítem
	var icon := TextureRect.new()
	var texture := load(item.get("path_img", ""))
	icon.texture = texture
	icon.custom_minimum_size = Vector2(32, 32)  # o el tamaño que quieras
	icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	hbox.add_child(icon)
	
	# Texto del ítem
	var label := Label.new()
	label.text = "- %s" % item.get("name", "Item sin nombre")
	hbox.add_child(label)
	
	# Añadir al inventario
	vbox.add_child(hbox)

func remove_item_inventory(item: Dictionary):
	for child in vbox:
		pass

func add_quest_ui(quest: Quest) -> void:
	var quest_box := VBoxContainer.new()
	quest_box.name = quest.title  # útil para identificarlo luego
	
	var title_label := Label.new()
	title_label.text = quest.title
	quest_box.add_child(title_label)
	
	var subtitle_label := Label.new()
	subtitle_label.text = "    " + quest.get_current_step().text_to_do
	quest_box.add_child(subtitle_label)
	
	var step := quest.get_current_step()
	if step:
		for id in step.necessary_interactables.keys():
			var id_text := "%s [%s]" % [
				id,
				"✔" if step.necessary_interactables[id] else "✘"
			]
			var step_label := Label.new()
			step_label.text = "    " + "    " +id_text
			quest_box.add_child(step_label)
	
	vbox2.add_child(quest_box)

func on_quest_updated(quest: Quest) -> void:
	var existing_box := vbox2.get_node_or_null(quest.title)
	if existing_box:
		vbox2.remove_child(existing_box)
		existing_box.queue_free()
	
	if not quest.is_completed():
		add_quest_ui(quest)


func on_item_updated(item: Dictionary):
	if item.is_in_player and not item.is_in_world:
		add_item_inventory(item)
	elif not item.is_in_player and not item.is_in_world:
		remove_item_inventory(item)
	
