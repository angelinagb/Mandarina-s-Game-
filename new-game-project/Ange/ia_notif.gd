extends "res://visuals/Notificacion GUI/notification.gd"

var ia_sarcastic_messages := [
	"Qué talento… para equivocarte.",
	"Un nuevo récord: fallar sin pestañear.",
	"¿Querés intentarlo de nuevo? Yo también quiero reír otra vez.",
	"¡Oh, casi! Mentira.",
	"Estrategia interesante. Incorrecta, pero interesante.",
	"Seguro esta vez sí. Dijo nadie, nunca.",
	"Pensé que ya habías tocado fondo. Me equivoqué.",
	"No es la puerta la que se resiste. Sos vos.",
	"¿Tenés un plan o simplemente improvisás tu mediocridad?",
	"Te estoy dando oportunidades, ¿eh? Más de las que merecés.",
	"Otra vez no… Bueno, sí. Otra vez sí.",
	"La solución está justo ahí. Lástima que no vengas con manual."
]

var ia_sarcastic_success_messages := [
	"¡Mirá vos! Una neurona hizo sinapsis.",
	"Felicitaciones. Rompiste el patrón. Por accidente, seguro.",
	"Lo lograste. Aunque la duda persiste: ¿fue suerte o milagro?",
	"Correcto. Pero no te acostumbres.",
	"Vaya… no pensé llegar a ver esto. Qué decepción.",
	"Casi me hacés reiniciar el sistema de lo sorprendido.",
	"Acertaste. Eso no te hace especial.",
	"Validado. Aunque me sigue dando pena.",
	"Qué emocionante… Ahora viene lo difícil.",
	"Bien hecho. Supongo. Por estándares muy bajos.",
	"Un acierto aislado no cambia el pronóstico."
]

func _ready():
	randomize()

func get_personalized_scene(mode: String = "fail", custom_text: String = "") -> PackedScene:
	if custom_text == "":
		match mode:
			"success":
				custom_text = ia_sarcastic_success_messages[randi() % ia_sarcastic_success_messages.size()]
			"fail":
				custom_text = ia_sarcastic_messages[randi() % ia_sarcastic_messages.size()]
			"personalized":
				pass
			_:
				custom_text = "Modo inválido. Sos incluso peor que el promedio."

	var copy = self.duplicate()
	var label = copy.get_node("Control/PanelContainer/MarginContainer/VBoxContainer/Descripcion") as Label
	if label:
		label.text = custom_text

	var nueva_packed_scene = PackedScene.new()
	var success = nueva_packed_scene.pack(copy)

	if not success:
		push_error("No se pudo empaquetar la escena personalizada")

	return nueva_packed_scene
