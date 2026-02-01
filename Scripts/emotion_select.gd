extends Control

@export var emotion_names: Array[String] = ["Love", "Motivation", "Nostalgia", "Happiness", "Kindness"]

@export_group("Buttons")
@export var button1: Button
@export var button2: Button
@export var button3: Button
@export var button4: Button
@export var button5: Button

@export_group("Result Images")
@export var image1: CanvasItem
@export var image2: CanvasItem
@export var image3: CanvasItem
@export var image4: CanvasItem
@export var image5: CanvasItem

func _ready() -> void:
	hide()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	visibility_changed.connect(_on_visibility_changed)
	
	button1.pressed.connect(_on_emotion_selected.bind(image1, 1))
	button2.pressed.connect(_on_emotion_selected.bind(image2, 2))
	button3.pressed.connect(_on_emotion_selected.bind(image3, 3))
	button4.pressed.connect(_on_emotion_selected.bind(image4, 4))
	button5.pressed.connect(_on_emotion_selected.bind(image5, 5))


func _on_visibility_changed() -> void:
	if visible:
		_set_buttons_disabled(false) 
		_hide_all_images()        
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _set_buttons_disabled(state: bool) -> void:
	if button1: button1.disabled = state
	if button2: button2.disabled = state
	if button3: button3.disabled = state
	if button4: button4.disabled = state
	if button5: button5.disabled = state

func _hide_all_images() -> void:
	if image1: image1.hide()
	if image2: image2.hide()
	if image3: image3.hide()
	if image4: image4.hide()
	if image5: image5.hide()

func _on_emotion_selected(selected_image: CanvasItem, index: int) -> void:

	_set_buttons_disabled(true)
	
	_hide_all_images()
	selected_image.show()
	
	await get_tree().create_timer(1.5).timeout
	

	if index - 1 < emotion_names.size():
		var chosen_emotion = emotion_names[index - 1]
		GameManager.npc_emotions.append(chosen_emotion)
	
	if GameManager.npcs_served >= GameManager.MAX_NPCS:
		_go_to_results()
	else:
		_return_to_kitchen()

func _go_to_results() -> void:
	SceneTransition.change_scene_to_file("res://scenes/ResultsPage.tscn")

func _return_to_kitchen() -> void:
	GameManager.current_step = GameManager.CookingStep.SERVE
	hide()
	
	

#hover cursor change on buttons
func _on_emotion_1_mouse_entered():
	Input.set_custom_mouse_cursor(load("res://cursor_2_hover.png"))
func _on_emotion_1_mouse_exited():
	Input.set_custom_mouse_cursor(load("res://cursor_1.png"))
func _on_emotion_2_mouse_entered():
	Input.set_custom_mouse_cursor(load("res://cursor_2_hover.png"))
func _on_emotion_2_mouse_exited():
	Input.set_custom_mouse_cursor(load("res://cursor_1.png"))
func _on_emotion_3_mouse_entered():
	Input.set_custom_mouse_cursor(load("res://cursor_2_hover.png"))
func _on_emotion_3_mouse_exited():
	Input.set_custom_mouse_cursor(load("res://cursor_1.png"))
func _on_emotion_4_mouse_entered():
	Input.set_custom_mouse_cursor(load("res://cursor_2_hover.png"))
func _on_emotion_4_mouse_exited():
	Input.set_custom_mouse_cursor(load("res://cursor_1.png"))
func _on_emotion_5_mouse_entered():
	Input.set_custom_mouse_cursor(load("res://cursor_2_hover.png"))
func _on_emotion_5_mouse_exited():
	Input.set_custom_mouse_cursor(load("res://cursor_1.png"))
	hide() 
