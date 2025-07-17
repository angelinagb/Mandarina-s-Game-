extends Node2D

# LOGICA JUGABLE
@onready var player			: PlayerB 
@onready var room_manager	: RoomManager 		= $RoomManager
@onready var inventory		: InventoryManager 	= $InventoryManager
@onready var quest			: QuestManager 		= $QuestManager
@onready var event			: EventManager	 	=$EventManager

# LOGICA APLICACION
@onready var save_manager	: SaveManager 		= $SaveManager

# VISUALES
@onready var dialogue		: DialogueManager 	= $DialogueManager
@onready var menu			: MenuManager 		=$menu
@onready var gui : GUI	= $gui

var current: IsoRoom

@onready var current_room_id : String = "ROOM-4"

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
		"Mate": {
			"id": "Mate",
			"name": "Mate",
			"desc": "el item 0",
			"path_img": "res://art/items/mate.png",
			"is_in_world": true,
			"is_in_player": false
		},
		"Termo": {
			"id": "Termo",
			"name": "Termo",
			"desc": "el item 1",
			"path_img": "res://art/items/termo.png",
			"is_in_world": true,
			"is_in_player": false
		},
		"Yerba": {
			"id": "Yerba",
			"name": "Yerba",
			"desc": "el item 2",
			"path_img": "res://art/items/yerba.png",
			"is_in_world": true,
			"is_in_player": false
		},
		"Capitulo1": {
			"id": "Capitulo1",
			"name": "Capitulo 1",
			"desc": "El capitulo 1 de la tesis.",
			"path_img": "res://art/items/book.png",
			"is_in_world": true,
			"is_in_player": false
		},
		"Capitulo2": {
			"id": "Capitulo2",
			"name": "Capitulo 2",
			"desc": "El capitulo 2 de la tesis.",
			"path_img": "res://art/items/book.png",
			"is_in_world": true,
			"is_in_player": false
		},
		"Capitulo3": {
			"id": "Capitulo3",
			"name": "Capitulo 3",
			"desc": "El capitulo 3 de la tesis.",
			"path_img": "res://art/items/book.png",
			"is_in_world": true,
			"is_in_player": false
		},
		"Capitulo4": {
			"id": "Capitulo4",
			"name": "Capitulo 4",
			"desc": "El capitulo 4 de la tesis.",
			"path_img": "res://art/items/book.png",
			"is_in_world": true,
			"is_in_player": false
		}
	}
	
	save_manager.save_dict({"actual_room": "res://Ange/intro_!iso_room.tscn", "prev_room": ""}, "RoomSetup")
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
	
func _ready():
	pass

func save_setup(room_save: Dictionary):
	save_manager.save_dict(room_save,"RoomSetup")
	save_manager.save_dict({},"PlayerSetup")
	save_manager.save_dict(inventory.get_items(), "Items")
	save_manager.save_dict(abilities_points, "AbilityPoints")
	save_manager.save_dict(abilities_available_points, "AbilityAvailablePoints")

func load_setup():
	var _player_setup: Dictionary = save_manager.load_dict("PlayerSetup")
	var room_setup: Dictionary = save_manager.load_dict("RoomSetup")
	
	var items: Dictionary = save_manager.load_dict("Items")
	
	abilities_points = save_manager.load_dict("AbilityPoints")
	abilities_available_points = save_manager.load_dict("AbilityAvailablePoints")
	
	inventory.initialize(items)
	inventory.game_ended.connect(on_game_ended)
	
	event.initialize([])
	
	quest.initialize(event, [])
	
	initialize_room(room_setup.actual_room, room_setup.prev_room)
	
	#player.initialize(current.get_position_spawn(room_setup.prev_room))
	
	dialogue.initialize()
	menu.initialize(quest, inventory, items)
	menu.on_abilities_updated(abilities_available_points.get("Points"), abilities_points)
	$menu.visible = false
	$menu.process_mode = Node.PROCESS_MODE_ALWAYS
	
func _on_interactable_interacted(interactable: Interactable):
	#todos los interactuables deberian avanzar quests
	#rehacer quest step para que acepte ID de cualquier interactuable
	#Falta guardar estado de items al cambiar de rooms
	#SEPARAR INTERACTABLES EN FASES, FASE 1, 2, ETC
	print("señal conectada")
	print(interactable.my_type)
	match interactable.my_type:
		"item":
			_on_item_grabbed(interactable)
		"transitioner":
			_on_transitioner_activated(interactable)
		"npc":
			await _on_npc_talked_to(interactable)
		"puzzle":
			await _on_puzzle_begin(interactable)
		"activator":
			await _on_activator_activate(interactable)
		_:
			print("no tengo interactuable" + interactable.my_type)
	
	event.interactable_triggered(interactable.id)
	

func _on_item_grabbed(item: Item) -> void:
	inventory.item_grabbed(item.getId())
	item.end()

func _on_transitioner_activated(transitioner: Transitioner) -> void:
	if transitioner.quest != null :
		transitioner.take_room_quest()
		quest.add_quest(transitioner.quest)
	var room_id: String = transitioner.get_room_id()
	change_room(room_id, current_room_id)
	current_room_id = room_id

func _on_npc_talked_to(npc: Npc) -> void:
	npc.startDialogue()
	await npc.dialogue_ended
	if npc.quest_available():
		npc.take_quest()
		quest.add_quest(npc.quest)
		

		
func _on_puzzle_begin(puzzle : Interactable):
		var dapuzzle = puzzle.puzzle_tcsn.instantiate()
		add_child(dapuzzle)
		print("llega")
		#player.pause_player()
		#var screen_size = get_viewport_rect().size
		#puzzle_instance.position = screen_size / 2
#		puzzle.monitoring = false
		dapuzzle.on_puzzle_solved.connect(on_puzzle_solved)
		dapuzzle.showp()
		gui.showbehind()

func initialize_room(path_room: String, temp: String ):
	current = room_manager.initialize(path_room)
	current.interactable_interacted.connect(_on_interactable_interacted)
	player = current.get_player()
	player.initialize(current.get_position_spawn(temp))

@warning_ignore("shadowed_variable")
func change_room(new_room_id: String, current_room_id: String):
	var room_save: Dictionary = {
		"actual_room": new_room_id,
		"prev_room": ""
	}
	
	save_setup(room_save)
	
	current = room_manager.change_room(new_room_id)
	
	player = current.get_player()
	
	current.interactable_interacted.connect(_on_interactable_interacted)
	
	player.move_to(current.get_position_spawn(current_room_id))

func _on_menu_ability_button_pressed(ability_name: String) -> void:
	if(ability_name!= null and abilities_points.get(ability_name)!= null):
		abilities_points.get(ability_name)[0] += 1
		abilities_available_points.set("Points", abilities_available_points.get("Points") - 1)
	menu.on_abilities_updated(abilities_available_points.get("Points"), abilities_points)


func _on_gui_button_open_menu_pressed() -> void:
	$menu.visible = true
	get_tree().paused = true
	$menu.process_mode = Node.PROCESS_MODE_ALWAYS
	
func on_puzzle_solved(Reward: String) :
	inventory.item_grabbed(Reward)
	player.resume_player()

func _on_quest_begin(interactable: Interactable):
	quest.add_quest(interactable.the_quest)

func _on_activator_activate(interactable: Activator):
	#QueueManager.enqueue_event(interactable.activable)
	pass
#func _on_inventory_manager_item_updated(item: Dictionary) -> void:
	#pass # Replace with function body.
#
#
#func _on_quest_manager_quest_updated(quest: Quest) -> void:
	#pass # Replace with function body.
#
#
#func _on_event_manager_event_added(event: String) -> void:
	#pass # Replace with function body.
	


#func _on_menu_quest_updated(quest_upd: Quest) -> void:
	#quest.update_quest(quest_upd)

func on_game_ended():
	add_child(load("res://Franco/Franco/end.tscn").instantiate())
