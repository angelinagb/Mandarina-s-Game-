class_name Puzzle extends Interactable


var completado : bool = false
var player_in_range: bool
@export var puzzle_tcsn : PackedScene

func _ready() -> void:
	player_in_range = false
	my_type = "puzzle"
	super._ready()


func _on_area_2d_body_entered(body: PlayerB):
	player_in_range = true 


func _on_close_puzzle_button_down() -> void:
	puzzle_tcsn.hide()


func _on_area_2d_body_exited(body: Node2D) -> void:
	player_in_range = false

func _process(delta: float) -> void:
	if player_in_range and 	 Input.is_action_just_pressed("ui_accept"):
			interacted.emit(self)
