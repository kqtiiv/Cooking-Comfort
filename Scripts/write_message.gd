extends Node3D

@export var required_step: GameManager.CookingStep
@export var next_step: GameManager.CookingStep
# removed hold_time since this is an instant click interaction

@onready var prompt: Label3D = $Prompt
@onready var object: Node3D = $Plate

var player_in_range: bool = false

func _ready() -> void:
	prompt.visible = false

func _process(delta: float) -> void:
	if player_in_range and GameManager.current_step == required_step:
		if Input.is_action_just_pressed("interact"):
			trigger_minigame()

func trigger_minigame() -> void:

	if not EmotionSelect.visible:
		EmotionSelect.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE 

func complete_interaction():
	GameManager.current_step = next_step
	print("Step Complete! Next: ", next_step)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player: 
		player_in_range = true
		update_prompt_visibility()

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is Player:
		player_in_range = false
		update_prompt_visibility()

func update_prompt_visibility():
	if player_in_range and GameManager.current_step == required_step:
		prompt.visible = true
	else:
		prompt.visible = false
