extends CanvasLayer

signal finished
@onready var mandarina: CharacterBody2D = $SubViewportContainer/SubViewport/Mandarina
@onready var sub_viewport_container: SubViewportContainer = $SubViewportContainer
@onready var marker_2d: Marker2D = $Marker2D
@onready var paper_sheet_floor: Sprite2D = $SubViewportContainer/SubViewport/BaseTiles/paper_sheet_floor
@onready var paper_sheet: Sprite2D = $SubViewportContainer/SubViewport/Mandarina/paper_sheet

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _process(delta: float) -> void:
	if mandarina.get_current_point() == 2 :
		drop_paper_sheet()
		
# Called when the node enters the scene tree for the first time.
func _ready():
	start()
# Called every frame. 'delta' is the elapsed time since the previous frame
	
func start():
	#await sub_viewport_container.ready
	#await get_tree().process_frame
	mandarina._begin_motion()  # o incluso con delay usando timer
	await mandarina.path_end
	mandarina.idle_and_look()
	finished.emit()
	
func drop_paper_sheet(): 
	paper_sheet.visible = false
	paper_sheet_floor.visible = true
