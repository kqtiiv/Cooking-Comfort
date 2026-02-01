extends Node3D

@export var required_step: GameManager.CookingStep
@export var next_step: GameManager.CookingStep
@export var hold_time: float = 2.0

@onready var audio = $Interact/sfx
@onready var prompt: Label3D = $Prompt
@onready var animation_obj: Node3D = $Interact
@onready var animation_player: AnimationPlayer = $Interact/AnimationPlayer

var is_holding: bool = false
var current_hold_timer: float = 0.0
var player_in_range: bool = false

func _ready() -> void:
	prompt.visible = false
	GameManager.start_new_order.connect(_reset_station)

func _reset_station():
	is_holding = false
	current_hold_timer = 0.0
	if animation_obj: animation_obj.hide() # Hides the cooked food
	if animation_player: animation_player.stop()

func _process(delta: float) -> void:
	if player_in_range and GameManager.current_step == required_step:
		if Input.is_action_pressed("interact"):
			is_holding = true
			current_hold_timer += delta
			
			var percent = (current_hold_timer / hold_time) * 100
			GameManager.send_hold_data(percent, true)
			
			if required_step == GameManager.CookingStep.RICE_COOKER:
				if not animation_player.is_playing(): 
					animation_player.play("rice")
					audio.play()
				
			elif required_step == GameManager.CookingStep.STOVE:
				animation_obj.show() 
				if not animation_player.is_playing(): 
					animation_player.play("egg")
					animation_player.play("Sphere_001Action")
					audio.play()
			
			if current_hold_timer >= hold_time:
				complete_interaction()
				GameManager.send_hold_data(0, false) 
				animation_player.stop()
				update_prompt_visibility()
		else:
			if is_holding:
				reset_hold()
				GameManager.send_hold_data(0, false)
				animation_player.stop()

func reset_hold():
	is_holding = false
	current_hold_timer = 0.0

func complete_interaction():
	GameManager.current_step = next_step
	is_holding= false
	current_hold_timer = 0.0
	player_in_range = false
	reset_hold()
	print("Step Complete! Next: ", next_step)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player and GameManager.current_step == required_step: 
		player_in_range = true
	update_prompt_visibility()

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is Player and GameManager.current_step == required_step: 
		player_in_range = false
	update_prompt_visibility()

func update_prompt_visibility():
	if player_in_range and GameManager.current_step == required_step:
		prompt.visible = true
	else:
		prompt.visible = false
