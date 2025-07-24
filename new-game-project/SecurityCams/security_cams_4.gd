extends CanvasLayer

signal finished
@onready var mandarina: CharacterBody2D = $SubViewportContainer/SubViewport/Mandarina
@onready var sub_viewport_container: SubViewportContainer = $SubViewportContainer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var paper_sheet: Sprite2D = $SubViewportContainer/SubViewport/Mandarina/paper_sheet
@onready var paper_sheet_floor: Sprite2D = $SubViewportContainer/SubViewport/BaseTiles/paper_sheet_floor


# Called when the node enters the scene tree for the first time.
func _ready():
	mandarina.position.x = 504.0
	mandarina.position.y = 193.0
	start()
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	if mandarina.get_current_point() == 2 :
		drop_paper_sheet()
	
func start():
	mandarina._begin_motion()  # o incluso con delay usando timer
	await mandarina.path_end
	mandarina.z_index = 20
	animation_player.play("jump_to_table")
	await animation_player.animation_finished
	mandarina.idle_and_look()
	finished.emit()

func drop_paper_sheet(): 
	paper_sheet.visible = false
	paper_sheet_floor.visible = true
