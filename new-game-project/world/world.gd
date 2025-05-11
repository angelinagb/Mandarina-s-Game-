extends Node2D

var main: Node

# LOGICA JUGABLE
@onready var player			: Player 			= $Player
@onready var room_manager	: RoomManager 		= $RoomManager
@onready var inventory		: InventoryManager 	= $InventoryManager
@onready var quest			: QuestManager 		= $QuestManager
@onready var event			: EventManager	 	= $EventManager

# LOGICA APLICACION
@onready var save_manager	: SaveManager 		= $SaveManager

# VISUALES
@onready var dialogue		: DialogueManager 	= $DialogueManager
@onready var menu			: MenuManager 		= $menu
@onready var gui			:  					= $gui

var current: Room

var abilities_points: Dictionary
var abilities_available_points: Dictionary

func save_this():
	var ability_points : Dictionary = {"Points": 10}
	var abilities: Dictionary = {
		"Estudio": [0, 5],
		"Animales": [0, 5],
		"Carisma": [0, 5]
	}
	
	var items = {
		"LlaveRoom2": {
			"id": "LlaveRoom2",
			"name": "LlaveRoom2",
			"desc": "el item llave room 2",
			"path_img": "res://art/items/key.png",
			"is_in_world": true,
			"is_in_player": false
		},
		"LlaveRoom5": {
			"id": "LlaveRoom5",
			"name": "LlaveRoom5",
			"desc": "el item llave room 5",
			"path_img": "res://art/items/key.png",
			"is_in_world": true,
			"is_in_player": false
		},
		"LlaveRoom6": {
			"id": "LlaveRoom6",
			"name": "LlaveRoom6",
			"desc": "el item llave room 6",
			"path_img": "res://art/items/key.png",
			"is_in_world": true,
			"is_in_player": false
		},
		"Mate": {
			"id": "Mate",
			"name": "Mate",
			"desc": "el item mate",
			"path_img": "res://art/items/mate.png",
			"is_in_world": true,
			"is_in_player": false
		},
		"Termo": {
			"id": "Termo",
			"name": "Termo",
			"desc": "el item termo",
			"path_img": "res://art/items/termo.png",
			"is_in_world": true,
			"is_in_player": false
		},
		"Yerba": {
			"id": "Yerba",
			"name": "Yerba",
			"desc": "el item yerba",
			"path_img": "res://art/items/yerba.png",
			"is_in_world": true,
			"is_in_player": false
		}
	}
	
	save_manager.save_dict({"actual_room": "res://rooms/room_1.tscn", "prev_room": ""}, "RoomSetup")
	save_manager.save_dict(items, "Items")
	save_manager.save_dict(abilities, "AbilityPoints")
	save_manager.save_dict(ability_points, "AbilityAvailablePoints")

func new_game():
	save_manager.reset_file()
	save_this()
	load_setup()
	
func resume_game():
	load_setup()
	
func delete_game():
	save_manager.reset_file()
	save_this()

func add_main(main: Node):
	self.main = main

func _ready():
	pass

func save_setup(room_save: Dictionary):
	save_manager.save_dict(room_save,"RoomSetup")
	save_manager.save_dict({},"PlayerSetup")
	save_manager.save_dict(inventory.get_items(), "Items")
	save_manager.save_dict(abilities_points, "AbilityPoints")
	save_manager.save_dict(abilities_available_points, "AbilityAvailablePoints")

func load_setup():
	var player_setup: Dictionary = save_manager.load_dict("PlayerSetup")
	var room_setup: Dictionary = save_manager.load_dict("RoomSetup")
	
	var items: Dictionary = save_manager.load_dict("Items")
	
	abilities_points = save_manager.load_dict("AbilityPoints")
	abilities_available_points = save_manager.load_dict("AbilityAvailablePoints")
	
	inventory.initialize(items)
	
	event.initialize(inventory, [])
	
	quest.initialize(event, [])
	
	initialize_room(room_setup.actual_room)
	
	player.initialize(current.get_position_spawn(room_setup.prev_room))
	
	dialogue.initialize()
	menu.initialize(self, quest, inventory, items, [])
	menu.on_abilities_updated(abilities_available_points.get("Points"), abilities_points)
	$menu.visible = false
	$menu.process_mode = Node.PROCESS_MODE_ALWAYS
	
func _on_interactable_interacted(interactable: Interactable):
	event.addEvent(interactable.getId())
	match interactable.my_type:
		"item":
			_on_item_grabbed(interactable)
		"door":
			_on_door_activated(interactable)
		"npc":
			_on_npc_talked_to(interactable)
		"puzzle_activator":
			_on_puzzle_activated(interactable)
		"_":
			pass

func _on_item_grabbed(item: Item) -> void:
	inventory.item_grabbed(item.getId())
	dialogue.start_dialogue(item.get_notification())
	item.end()

func _on_door_activated(door: Door) -> void:
	if door.is_open():
		var new_room_path: String = door.get_new_room_path()
		var id_prev_room: String = current.get_room_identifier()
		change_room(new_room_path, id_prev_room)
	else:
		if inventory.get_items_in_player().has(door.get_necessary_item_id()):
			inventory.item_used(door.get_necessary_item_id())
			door.open_door()
		else:
			dialogue.start_dialogue(door.get_notification())

func _on_npc_talked_to(npc: NpcQuestGiver) -> void:
	npc.define_state(event.getEvents())
	if npc.get_actual_state() == npc.STATES.QUEST_GIVE:
		quest.add_quest(npc.get_quest())
		dialogue.start_dialogue(npc.get_dialogues()[0])
		event.addEvent("FrancoQuestGiven")
	elif npc.get_actual_state() == npc.STATES.QUEST_WAIT:
		dialogue.start_dialogue(npc.get_dialogues()[1])
	elif npc.get_actual_state() == npc.STATES.QUEST_COMPLETE:
		for child in npc.necessary_events:
			inventory.item_used(child)
		dialogue.start_dialogue(npc.get_dialogues()[2])
		event.addEvent("FrancoQuestCompleted")
	elif npc.get_actual_state() == npc.STATES.END_INTERACTION:
		dialogue.start_dialogue(npc.get_dialogues()[3])

func _on_puzzle_activated(puzzle: Puzzle_Activator) -> void:
	var active_puzzle = load(puzzle.path_scene).instantiate()
	add_child(active_puzzle)
	active_puzzle.process_mode = Node.PROCESS_MODE_ALWAYS
	active_puzzle.add_father(self)
	active_puzzle.puzzle_result.connect(_on_puzzle_result.bind(puzzle))
	active_puzzle.visible = true
	active_puzzle.set_z_index(1000)
	self.process_mode = Node.PROCESS_MODE_DISABLED

func initialize_room(path_room: String):
	current = room_manager.initialize(path_room)
	current.init_items(inventory.get_items_in_world())
	current.init_transitioners(inventory.get_items_in_world(), inventory.get_items_in_player())
	current.init_npc([])
	current.init_puzzles([])
	current.interactable_interacted.connect(_on_interactable_interacted)

func change_room(path_room: String, id_prev_room: String):
	var room_save: Dictionary = {
		"actual_room": path_room,
		"prev_room": ""
	}
	
	save_setup(room_save)
	
	current = room_manager.change_room(path_room)
	
	current.init_items(inventory.get_items_in_world())
	current.init_transitioners(inventory.get_items_in_world(), inventory.get_items_in_player())
	current.init_npc([])
	
	current.interactable_interacted.connect(_on_interactable_interacted)
	
	player.move_to(current.get_position_spawn(id_prev_room))

func _on_menu_ability_button_pressed(ability_name: String) -> void:
	if(ability_name!= null and abilities_points.get(ability_name)!= null):
		abilities_points.get(ability_name)[0] += 1
		abilities_available_points.set("Points", abilities_available_points.get("Points") - 1)
	menu.on_abilities_updated(abilities_available_points.get("Points"), abilities_points)

func _on_gui_button_open_menu_pressed() -> void:
	$menu.visible = true
	$menu.process_mode = Node.PROCESS_MODE_ALWAYS
	self.process_mode = Node.PROCESS_MODE_DISABLED
	# get_tree().paused = true
	# $menu.process_mode = Node.PROCESS_MODE_ALWAYS


func _on_menu_on_go_to_start_menu_button_pressed() -> void:
	main.open_start_menu()

func _on_puzzle_result(result: bool, active_puzzle: Puzzle_Activator):
	print(result)
	if result:
		inventory.item_grabbed(active_puzzle.item)
		active_puzzle.end()
