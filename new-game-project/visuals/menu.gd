class_name MenuManager extends CanvasLayer

signal ability_button_pressed(ability_name: String)

@onready var item_container := %"Conteneder Inventario"
@onready var quest_container := %"Contenedor Quest"
@export var elemento_quest : PackedScene
@export var elemento_inventario : PackedScene


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
	var item_box := elemento_inventario.instantiate()
	item_container.add_child(item_box)
	
	var texture := load(item.get("path_img", ""))
	item_box.set_icono(texture)
	item_box.set_titulo("- %s" % item.get("name", "Item sin nombre"))

func remove_item_inventory(item: Dictionary):
	for child in item_container.get_children():
		pass

func add_quest_ui(quest: Quest) -> void:
	var quest_box := elemento_quest.instantiate()
	quest_container.add_child(quest_box)
	quest_box.set_nombre_elemento(quest.title)  # útil para identificarlo luego
	quest_box.set_titulo(quest.title)
	quest_box.set_paso("    " + quest.get_current_step().text_to_do)
	
	#var step := quest.get_current_step()
	#if step:
		#for id in step.necessary_interactables.keys():
			#var id_text := "%s [%s]" % [
				#id,
				#"✔" if step.necessary_interactables[id] else "✘"
			#]
			#var step_label := Label.new()
			#step_label.text = "    " + "    " +id_text
			#step_label.add_theme_color_override("font_color", Color(0, 0, 200))
#
			#quest_box.add_child(step_label)
	
	quest_container.add_child(quest_box)

func on_quest_updated(quest: Quest) -> void:
	var existing_box := quest_container.get_node_or_null(quest.title)
	if existing_box:
		quest_container.remove_child(existing_box)
		existing_box.queue_free()
	
	if not quest.is_completed():
		add_quest_ui(quest)

func on_item_updated(item: Dictionary):
	if item.is_in_player and not item.is_in_world:
		add_item_inventory(item)
	elif not item.is_in_player and not item.is_in_world:
		remove_item_inventory(item)

func on_abilities_updated(points_available: int, abilities: Dictionary):
	#$Control2/MainMenu.update(points_available, abilities)
	pass

func _on_main_menu_ability_button_pressed(ability_name: String) -> void:
	ability_button_pressed.emit(ability_name)

func _on_exit_button_pressed() -> void:
	self.visible = false
	get_tree().paused = false
