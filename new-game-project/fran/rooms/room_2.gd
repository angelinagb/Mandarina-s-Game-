extends Room

signal changed_room(DestinyRoom)
signal item_grabbed(itemId)
signal dialogue_ended()

@onready var tr3: transitioner = $TransitionerTo3
@onready var tr1: transitioner = $TransitionerTo1

@onready var dialogueItem1 : DialogueSys = $DialogueItem1
@onready var dialogueItem2 : DialogueSys = $DialogueItem2

func getPositionSpawn(entered_from: String):
	match entered_from:
		"room_1":
			return $SpawnFrom1.position
		"room_3":
			return $SpawnFrom3.position
		_:
			return super.getPositionDefect()
			
func _on_transitioner_to_3_body_entered(body: Node2D) -> void:
	changed_room.emit(tr3.getDestinyRoom())

func _on_transitioner_to_1_body_entered(body: Node2D) -> void:
	changed_room.emit(tr1.getDestinyRoom())

func _on_item_1_grabbed() -> void:
	item_grabbed.emit($Item1.getId())
	$Item1.delete()
	dialogueItem1.start()
	
func _on_item_2_grabbed() -> void:
	item_grabbed.emit($Item2.getId())
	$Item2.delete()
	dialogueItem2.start()
	
func _on_dialogue_item_1_dialogue_ended() -> void:
	dialogue_ended.emit()

func _on_dialogue_item_2_dialogue_ended() -> void:
	dialogue_ended.emit()
