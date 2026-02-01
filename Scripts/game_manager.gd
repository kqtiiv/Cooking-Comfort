extends Node
var is_dialogue_active: bool = false

enum CookingStep { TALK_TO_CUSTOMER, RICE_COOKER, STOVE, START_MINIGAME, SERVE }
var current_step: CookingStep = CookingStep.TALK_TO_CUSTOMER
signal request_next_npc

const correct_emotions: Array[String] = ["Motivation", "Happiness", "Nostalgia"]

var npc_emotions: Array[String] = []
var npcs_served: int = 0
const MAX_NPCS: int = 3

signal start_new_order 

func reset_game_state():
	npc_emotions.clear()
	npcs_served = 0
	current_step = CookingStep.TALK_TO_CUSTOMER
	start_new_order.emit()

signal update_hold_ui(percentage: float, is_visible: bool)

func send_hold_data(percent: float, visible: bool) -> void:
	update_hold_ui.emit(percent, visible)
