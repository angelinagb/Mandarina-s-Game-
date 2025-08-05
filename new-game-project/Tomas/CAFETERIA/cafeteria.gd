extends IsoRoom

@export var dialogo_intro : PackedScene
@onready var anim_player : AnimationPlayer = $CinematicasCafeteria
@onready var key1: Key = $Interactables/Items/Item
@onready var key2: Key = $Interactables/Items/Item2

var level_completed = false
var said = false

func _ready() -> void:
	#for child in $"Interactables/Npcs/SPRITE VENDEDOR".get_children():
		#if child and child is Npc:
				#child.item_used.connect(_on_item_used)
	#for child in $Interactables/Npcs.get_children():
		#if child and child is Npc:
			#child.item_used.connect(_on_item_used)
			#
	current_state = StateManager.get_room_state(room_id)
	restore_state()
	
	add_to_group("Con Estado")
	if not said:
		intro()
	else :
		return
	
	if level_completed:
		for node : Node in get_tree().get_nodes_in_group("COFFEE_END"):
			node.process_mode = Node.PROCESS_MODE_INHERIT
		key1.queue_free()
		key2.queue_free()
		
		
	
func intro():
	said = true
	
	player_b.esconder_joystick()
	anim_player.play("fade_out")
	await anim_player.animation_finished
	QueueManager.enqueue_event(dialogo_intro)
	await QueueManager.finished
	player_b.mostrar_joystick()
	
	#anim_player.play("intro")
	#await anim_player.animation_finished
 




func _on_vendedor_q_1_quest_begun() -> void:
	#Empieza Quest 1, habilito los grupos para interactuar
	for node : Node in get_tree().get_nodes_in_group("Q1_GRUPOS"):
		node.process_mode = Node.PROCESS_MODE_INHERIT


#func _on_vendedor_q_1_quest_ended(title: Variant) -> void:
	#for node : Node in get_tree().get_nodes_in_group("Q1"):
		#node.process_mode = Node.PROCESS_MODE_DISABLED
	#for node : Node in get_tree().get_nodes_in_group("Q2"):
		#node.process_mode = Node.PROCESS_MODE_INHERIT

	
func _on_vendedor_q_2_quest_ended(title: Variant) -> void:
	for node : Node in get_tree().get_nodes_in_group("Q2"):
		node.process_mode = Node.PROCESS_MODE_DISABLED
		node.visible = false
	for node : Node in get_tree().get_nodes_in_group("COFFEE_END"):
		node.process_mode = Node.PROCESS_MODE_INHERIT
	
	await NotificationManager.finished
	key1.interact()
	key2.interact()
	level_completed = true


func _on_vendedor_q_2_quest_begun() -> void:
	for node : Node in get_tree().get_nodes_in_group("Q2_BEGIN"):
		node.process_mode = Node.PROCESS_MODE_INHERIT


func _on_grupo_3_dialogue_ended() -> void:
	for node : Node in get_tree().get_nodes_in_group("Q1"):
		node.process_mode = Node.PROCESS_MODE_DISABLED
	for node : Node in get_tree().get_nodes_in_group("Q2"):
		node.process_mode = Node.PROCESS_MODE_INHERIT
		
		

func get_state() -> Dictionary:
	return {
		"dialogue_said": said,
		"level_completed": level_completed
	}

func load_state(state: Dictionary) -> void:
	if state.has("dialogue_said"):
		said = state["dialogue_said"]
		level_completed = state["level_completed"] 
	
