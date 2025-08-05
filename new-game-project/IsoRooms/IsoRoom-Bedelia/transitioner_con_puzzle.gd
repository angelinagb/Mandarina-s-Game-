extends Transitioner

const BLOCKED_BY_IA = preload("res://Ange/blocked_by_ia.tscn")
@export var puzzle: PackedScene

signal unblocked
# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.


func interact() :
	if puzzle and necesary_key: 
		var puzzle_instance: Puzzle
		puzzle_instance = puzzle.instantiate()
		puzzle_instance.puzzle_result.connect(_on_puzzle_result)
		add_child(puzzle_instance)
	else:
		super.interact()

func _on_puzzle_result(result):
	var scene
	if result:
		self.necesary_key = false
		scene= BLOCKED_BY_IA.instantiate().get_personalized_scene("success")
		unblocked.emit()
		super.interact()

	else:
		scene = BLOCKED_BY_IA.instantiate().get_personalized_scene("fail")  
	NotificationManager.enqueue_event(scene)
