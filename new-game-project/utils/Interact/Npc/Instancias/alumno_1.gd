extends Npc

@export var puzzle : PackedScene
@onready var dialogo_sistema : DialogueSystem = $"Dialogue System"
@export var dialogo_victoria : Dialogo
@export var quest_completed : PackedScene

func startDialogue():
	super.startDialogue()
	await dialogue_ended
	QueueManager.enqueue_event(puzzle)
	await QueueManager.finished
	dialogo_sistema.dialogueResource = dialogo_victoria
	dialogo_sistema.start()
	await dialogo_sistema.dialogue_ended
	QueueManager.enqueue_event(quest_completed)
	
