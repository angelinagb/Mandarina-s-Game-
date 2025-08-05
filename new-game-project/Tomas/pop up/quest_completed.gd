extends CanvasLayer

signal finished

@onready var nombre_quest : Label = $"PanelContainer/PanelContainer/VBoxContainer/Nombre Quest"
@onready var anim_player : AnimationPlayer = $AnimationPlayer

func set_nombre_quest(nombre):
	nombre_quest.text = nombre
	
	

func start():
	anim_player.play("fade_in_quest")
	await anim_player.animation_finished
	anim_player.play("fade_out_quest")
	await anim_player.animation_finished
	finished.emit()
	queue_free()

#es basicamente un clone
func get_personalized_scene(new_nombre_quest: String) -> PackedScene:
	var copy = self.duplicate()
	var label = copy.get_node("PanelContainer/PanelContainer/VBoxContainer/Nombre Quest") as Label
	if label:
		label.text = new_nombre_quest
	
	var nueva_packed_scene = PackedScene.new()
	var success = nueva_packed_scene.pack(copy)
	
	if not success:
		push_error("No se pudo empaquetar la escena personalizada")

	return nueva_packed_scene
