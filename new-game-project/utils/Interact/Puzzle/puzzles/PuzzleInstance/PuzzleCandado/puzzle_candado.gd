extends Puzzle

@onready var submit: Button = $Background/Submit

@onready var first_digit: Panel = $Background/FirstDigit
@onready var second_digit: Panel = $Background/SecondDigit
@onready var third_digit: Panel = $Background/ThirdDigit
@onready var fourth_digit: Panel = $Background/FourthDigit

@onready var first_0: Label = $"Background/FirstDigit/MarginContainer/VBoxContainer/0"
@onready var second_0: Label = $"Background/SecondDigit/MarginContainer/VBoxContainer/0"
@onready var third_0: Label = $"Background/ThirdDigit/MarginContainer/VBoxContainer/0"
@onready var fourth_0: Label = $"Background/FourthDigit/MarginContainer/VBoxContainer/0"

@onready var result: Label = $Background/Result

var CORRECT_COMBINATION = [3, 1, 4, 2]

func check_solution():
	var ACTUAL_COMBINATION = [
		first_digit.get_selected_number(),
		second_digit.get_selected_number(),
		third_digit.get_selected_number(),
		fourth_digit.get_selected_number()
	]
	if ACTUAL_COMBINATION == CORRECT_COMBINATION:
		await update_response_label("¡Abriste el candado!")
		end_puzzle(true)
	else:
		await update_response_label("¡Fallaste abriendo el candado!")
		open_popup_menu()

func _on_submit_pressed() -> void:
	check_solution()

func open_popup_menu():
	popupmenu_instance = load(POPUPMENU_PATH).instantiate()
	popupmenu_instance.replay_pressed.connect(on_replay_pressed)
	popupmenu_instance.out_pressed.connect(on_out_pressed)
	add_child(popupmenu_instance)

func on_replay_pressed():
	restart_puzzle()

func on_out_pressed():
	end_puzzle(false)

func end_puzzle(result: bool):
	super.on_puzzle_result(result)
	super.end()

func restart_puzzle():
	resume()
	
	first_digit.current_offset = 0
	first_digit.update_number_display()
	first_0.show()
	
	second_digit.current_offset = 0
	second_digit.update_number_display()
	second_0.show()
	
	third_digit.current_offset = 0
	third_digit.update_number_display()
	third_0.show()
	
	fourth_digit.current_offset = 0
	fourth_digit.update_number_display()
	fourth_0.show()
	
func update_response_label(text: String):
	pause()
	result.text = text
	await get_tree().create_timer(5.0).timeout
	result.text = ""

func pause():
	submit.disabled = true
	first_digit.set_process_input(false)
	second_digit.set_process_input(false)
	third_digit.set_process_input(false)
	fourth_digit.set_process_input(false)

func resume():
	submit.disabled = false
	first_digit.set_process_input(true)
	second_digit.set_process_input(true)
	third_digit.set_process_input(true)
	fourth_digit.set_process_input(true)
