extends Puzzle

@export_range(0,1) var bot_prob_of_lie: float

@onready var card_manager: CardManager = $CardManager
@onready var card_2: Control = $PlayerCards/Card2
@onready var card_3: Control = $PlayerCards/Card3
@onready var card_1: Control = $PlayerCards/Card1
@onready var anim: AnimationPlayer = $AnimationPlayer

@onready var card_npc_1: Control = $Slot_Juego_1/Card_npc
@onready var card_player_1: Control = $Slot_Juego_1/Card_player
@onready var card_npc_2: Control = $Slot_Juego_2/Card_npc
@onready var card_player_2: Control = $Slot_Juego_2/Card_player
@onready var card_npc_3: Control = $Slot_Juego_3/Card_npc
@onready var card_player_3: Control = $Slot_Juego_3/Card_player

var can_play = false # si el user juega
var turn: int = 0

var player_hand
var npc_hand

var is_player_hand: bool
var animation_cycle_count := 0

func _ready() -> void:
	card_manager.create_deck()
	deal_cards()
	start_game()

func _on_card_selected(card):
	print(player_hand)
	if can_play and turn < 3:
		player_hand.erase(card)
		can_play = false
		match turn:
			0:
				card.reparent(card_player_1)
			1:
				card.reparent(card_player_2)
			2:
				card.reparent(card_player_3)

	card.position = Vector2.ZERO
	bot_juega()

func deal_cards():
	randomize()
	is_player_hand = randi() % 2 == 0
	
	card_manager.shuffle_deck()
	player_hand = card_manager.deal_cards()
	npc_hand = card_manager.deal_cards()
	
	for card in player_hand:
		card.selected.connect(_on_card_selected)
		
	if is_player_hand:
		drag_cards("user")
	else:
		drag_cards("bot")
	
	card_1.add_child(player_hand[0])
	card_2.add_child(player_hand[1])
	card_3.add_child(player_hand[2])
	

func drag_cards(hand: String):
	for i in range(3):
		if hand == "user":
			anim.play("drag_user")
			await anim.animation_finished
			anim.play("drag_bot")
			await anim.animation_finished
		else:
			anim.play("drag_bot")
			await anim.animation_finished
			anim.play("drag_user")
			await anim.animation_finished
	
	$Mazo2.visible = false
	$Mazo.visible = false
	$PlayerCards.visible = true
	$npcCards.visible = true
	anim.play("in")
	
func bot_juega():
	var slot
	var card

	match turn:
		0: slot = card_npc_1
		1: slot = card_npc_2
		2: slot = card_npc_3
		
	var carta = npc_hand[turn]

	# 🟡 Decide si cantar envido en el primer turno
	if turn == 0 and should_cantar_envido():
		cantar_envido()  # Suponiendo que tenés esta función
		return
	
	# 🔴 Decide si cantar truco según su mano o miente
	if should_cantar_truco() or bot_should_lie():
		cantar_truco()
		return

	# 🔵 Juega carta si no cantó nada
	slot.add_child(carta)
	carta.visible = true
	turn += 1
	
func bot_should_lie() -> bool:
	return randf() < bot_prob_of_lie

func should_cantar_truco() -> bool:
	var average_strength = 0.0
	for card in npc_hand:
		average_strength += card_manager.get_power(card.palo, card.card_number)  # Reemplazar por el método o atributo real
	average_strength /= 3.0

	# Umbral base de fuerza para decidir cantar truco
	return average_strength > 6.5
	
func should_cantar_envido() -> bool:
	# Suponiendo que cada carta tiene atributos 'palo' y 'numero'
	var envido_score = calculate_envido(npc_hand)
	return envido_score >= 26 or (envido_score > 20 and bot_should_lie())

func check_envido():
	var bot_score = calculate_envido(npc_hand)
	var player_score = calculate_envido(player_hand)
	print("Envido Bot:", bot_score, "vs Player:", player_score)

	if bot_score > player_score:
		print("Bot gana el envido")
	else:
		print("Jugador gana el envido")
	# Continuar el juego
	can_play = true
	

func check_truco():
	print("Se jugó un TRUCO. Aún no implementada comparación de cartas.")
	can_play = true
	
func _on_truco_cantado():
	# Aquí iría el sistema de respuesta del jugador
	print("Bot cantó TRUCO")
	# Esperar respuesta del jugador: aceptar, rechazar, retrucar...
	check_truco()


func _on_envido_cantado(
	
):
	# Aquí iría el sistema de respuesta del jugador
	print("Bot cantó ENVIDO")
	# Esperar respuesta del jugador: aceptar o rechazar...
	check_envido()

func cantar_envido():
	_on_envido_cantado()


func cantar_truco():
	_on_truco_cantado()


func calculate_envido(hand) -> int:
	var max_score = 0
	for i in range(3):
		for j in range(i + 1, 3):
			var card1 = hand[i]
			var card2 = hand[j]
			if card1.palo == card2.palo:
				var val1 = min(card1.numero, 7)  # Envido cuenta hasta 7
				var val2 = min(card2.numero, 7)
				var score = val1 + val2 + 20
				max_score = max(max_score, score)
	return max_score



	
func start_game():
	if is_player_hand:
		can_play = true
	else: 
		bot_juega()
