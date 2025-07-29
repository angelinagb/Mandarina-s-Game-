extends Npc
class_name Merchant

signal request_item_check(item_id: String, merchant_ref: Object)
signal response_item_check(result: bool, necesary: String )

#necesario[pedido]
@export var trades : Dictionary = {
	"Termo Vacio": "Termo Lleno"
}

#var posiciones : Array[String] = []

@onready var dialogue_system : DialogueSystem = $"Dialogo Default"

var n_item: Item
var default

func _ready():
	default = dialogue_system.dialogueResource
	n_item = Item.new()
	n_item.my_type = "item"
	response_item_check.connect(_on_response)
	#item_used.connect(_on_item_used)
	super._ready()
	
	
func _show_message(texto: String) -> void:
	if dialogue_system:
		dialogue_system.set_speaker(npc_name)
		dialogue_system.dialogo_alternativo = create_dialogue_resource(texto)
	else:
		print("error")

func create_dialogue_resource(texto: String) -> Dialogo:
	var d = Dialogo.new()
	d.arreglo_de_textos.append(texto)
	return d

func create_stock() -> void:
	if dialogue_system:
		dialogue_system.set_speaker(npc_name)
		var decision = Decision.new()

		for needed_item in trades.keys():
			var reward_item = trades[needed_item]

			var opcion = Opcion.new()
			opcion.texto = "Obtener: " + reward_item + "\n Necesitas: " + needed_item
			opcion.decision_type = "Market"
			#posiciones.append(needed_item)
			var evento = EventoTrade.new(needed_item,reward_item,self)
			opcion.array_eventos.append(evento)
			decision.array_opciones.append(opcion) 
			
		dialogue_system.dialogueResource.decision = decision
		dialogue_system.start()


func do_trade(required_item: String, reward_item: String) -> void:
	
	self.gives_item = reward_item
	
	dialogue_system.use_item.connect( _on_item_used )
	dialogue_system.deliver_item.connect(item_selected)
	
	dialogue_system.deliver_item.emit(reward_item)

	dialogue_system.use_item.emit(required_item)

	_show_message("Gracias por el intercambio! Aquí tienes tu " + trades[required_item])
	

func startDialogue():
	dialogue_system.dialogueResource = default
	create_stock()  # Arma las opciones según los trades

	dialogue_system.set_speaker(self.npc_name)
	dialogue_system.start()
	await dialogue_system.finished  # Esperar que el diálogo termine



func _on_response(result, necesary) :
	if result:
		do_trade(necesary, trades[necesary])
	else:
		_show_message("Necesitas (1) " + necesary + " para obtener (1) " + trades[necesary])
		

func item_selected(item_id):
	n_item.id = item_id
	n_item.interact()
