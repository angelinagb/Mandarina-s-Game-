extends Node2D

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
@onready var gui			: GuiManager 		= $gui

var current: Room

func save_this():
	var i = {
		"Mate": {
			"id": "Mate",
			"name": "Mate",
			"desc": "el item 0",
			"path_img": "res://art/mate.png",
			"is_in_world": true,
			"is_in_player": false
		},
		"Termo": {
			"id": "Termo",
			"name": "Termo",
			"desc": "el item 1",
			"path_img": "res://art/termo.png",
			"is_in_world": true,
			"is_in_player": false
		},
		"Yerba": {
			"id": "Yerba",
			"name": "Yerba",
			"desc": "el item 2",
			"path_img": "res://art/yerba.png",
			"is_in_world": true,
			"is_in_player": false
		}
	}
	
	save_manager.save_dict({"actual_room": "res://rooms/room_1.tscn", "prev_room": ""}, "RoomSetup")
	save_manager.save_dict(i, "Items")

func _ready():
	save_manager.reset_file()
	save_this()
	load_setup()

func save_setup(room_save: Dictionary):
	save_manager.save_dict(room_save,"RoomSetup")
	save_manager.save_dict({},"PlayerSetup")
	save_manager.save_dict(inventory.get_items(), "Items")

func load_setup():
	var player_setup: Dictionary = save_manager.load_dict("PlayerSetup")
	var room_setup: Dictionary = save_manager.load_dict("RoomSetup")
	
	var items: Dictionary = save_manager.load_dict("Items")
	
	inventory.initialize(items)
	
	event.initialize(inventory, [])
	
	quest.initialize(event, [])
	
	initialize_room(room_setup.actual_room)
	
	player.initialize(current.get_position_spawn(room_setup.prev_room))
	
	dialogue.initialize()
	gui.initialize(quest, inventory, items, [])
	
func _on_interactable_interacted(interactable: Interactable):
	match interactable.my_type:
		"item":
			_on_item_grabbed(interactable)
		"transitioner":
			_on_transitioner_activated(interactable)
		"npc":
			_on_npc_talked_to(interactable)
		_:
			pass

func _on_item_grabbed(item: Item) -> void:
	inventory.item_grabbed(item.getId())
	
	item.end()

func _on_transitioner_activated(transitioner: Transitioner) -> void:
	var path_room: String = transitioner.get_path_room()
	var id_prev_room: String = current.get_room_identifier()
	change_room(path_room, id_prev_room)

func _on_npc_talked_to(npc: Npc) -> void:
	await dialogue.start_dialogue(npc.getDialogue())
	if npc.quest_available():
		npc.take_quest()
		quest.add_quest(npc.quest)
	npc.stopped_talking()

func initialize_room(path_room: String):
	current = room_manager.initialize(path_room)
	current.init_items(inventory.get_items_in_world())
	current.init_transitioners([])
	current.init_npc([])
	current.interactable_interacted.connect(_on_interactable_interacted)
	
func change_room(path_room: String, id_prev_room: String):
	var room_save: Dictionary = {
		"actual_room": path_room,
		"prev_room": ""
	}
	
	save_setup(room_save)
	
	current = room_manager.change_room(path_room)
	
	current.init_items(inventory.get_items_in_world())
	current.init_transitioners([])
	current.init_npc([])
	
	current.interactable_interacted.connect(_on_interactable_interacted)
	
	player.move_to(current.get_position_spawn(id_prev_room))
