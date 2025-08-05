extends Evento
class_name EventoTrade

@export var needed_item : String
@export var reward_item : String

signal end_trade

var merchant_ref : Merchant

func _init(needed_item: String, reward_item: String, merchant_ref: Merchant):
	self.needed_item = needed_item
	self.reward_item = reward_item
	self.merchant_ref = merchant_ref

func trigger() -> void:
	# Emitir para consultar si el jugador tiene el needed_item
	merchant_ref.emit_signal("request_item_check", needed_item, merchant_ref)
