extends PanelContainer

@onready var icono : TextureRect = %Icono
@onready var titulo : Label = %Titulo

func set_titulo(nuevo_titulo):
	titulo.text = nuevo_titulo
	
func set_icono(textura):
	icono.texture = textura
