extends Room

signal changed_room(DestinyRoom)
signal item_grabbed(itemId)
signal dialogue_ended()

@onready var tr2: transitioner = $TransitionerTo2

@onready var dialogueItem1 : DialogueSys = $DialogueItem1

func getPositionSpawn(entered_from: String):
	match entered_from:
		"room_2":
			return $SpawnFrom2.position
		_:
			return super.getPositionDefect()
			
func _on_transitioner_to_2_body_entered(body: Node2D) -> void:
	changed_room.emit(tr2.getDestinyRoom())

func _on_item_1_grabbed() -> void:
	item_grabbed.emit($Item1.getId())
	$Item1.delete()
	dialogueItem1.start()
	
func _on_dialogue_item_1_dialogue_ended() -> void:
	dialogue_ended.emit()
