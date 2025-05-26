extends PanelContainer


@onready var titulo : Label = %Titulo
@onready var paso : Label = %Paso

func set_nombre_elemento(nuevo_nombre):
	name = nuevo_nombre

func set_titulo(nuevo_titulo):
	titulo.text = nuevo_titulo

func set_paso(nuevo_paso):
	paso.text = nuevo_paso
