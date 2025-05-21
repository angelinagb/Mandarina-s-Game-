extends Room

@onready var canvas = $CanvasModulate
@onready var switch = $Interactables/Items/Switch
@onready var npc = $Npc1

var originalcolor = "dbdbdb"

func _ready(): pass

func get_room_identifier(): return room_identifier

func init_items(item_dict: Array[String]):
	for child: Item in $Interactables/Items.get_children():
		if item_dict.has(child.getId()):
			child.start()
			child.interacted.connect(_on_interactable_interacted)

func init_transitioners(transitioner_dict: Array[String]):
	for child: Transitioner in $Interactables/Transitioners.get_children():
		child.start()
		child.interacted.connect(_on_interactable_interacted)

func init_npc(npc_dict: Array[String]):
	for child: Npc in $Interactables/Npcs.get_children():
		child.start()
		child.interacted.connect(_on_interactable_interacted)

func start_interactables():
	for child in $Interactables.get_children():
		if child is Interactable:
			child.start()
			child.interacted.connect(_on_interactable_interacted)

func get_position_spawn(name_spawn: String) -> Vector2:
	for child in $Spawns.get_children():
		if child is Marker2D and child.name == name_spawn:
			return child.position
	return $Spawns/defect.position

func _on_interactable_interacted(interactable: Interactable):
	interactable_interacted.emit(interactable)


func _on_switch_body_entered(body: Node2D) -> void:
	canvas.set_color("a15252")
	switch.pressed(true)

func _on_switch_body_exited(body: Node2D) -> void:
	canvas.set_color(originalcolor)
	switch.pressed(false)
	
