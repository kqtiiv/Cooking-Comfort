extends Control

@onready var text_label = $storybg/dialogue
@export var type_speed: float = 0.05

func _ready() -> void:
	hide()
	text_label.visible_ratio = 0.0
	process_mode = Node.PROCESS_MODE_ALWAYS 

func display_text(content: String = "...") -> void:
	# If the string is empty, we assume the conversation is over
	if content == "":
		_close_dialogue()
		return

	show()
	GameManager.is_dialogue_active = true 
	text_label.text = content
	text_label.visible_ratio = 0.0
	
	var duration = content.length() * type_speed
	var tween = create_tween()
	tween.tween_property(text_label, "visible_ratio", 1.0, duration)

func _input(event: InputEvent) -> void:
	var is_click = event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed
	var is_interact = event.is_action_pressed("interact")

	if GameManager.is_dialogue_active and (is_interact or is_click):
		# If text is still typing, skip to the end
		if text_label.visible_ratio < 1.0:
			text_label.visible_ratio = 1.0
			get_viewport().set_input_as_handled() 
		
		# If text is finished typing...
		else:
			pass

func _close_dialogue() -> void:
	hide()
	GameManager.is_dialogue_active = false
