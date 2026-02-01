extends Control

static var _instance: OptionsUI = null
static var Instance: OptionsUI:
	get: return _instance
	
@onready var audio = $OptionsUI/Content/button_click

@export var soundEffectsButton: Button
@export var musicButton: Button
@export var closeButton: Button

var _onCloseButtonAction: Callable

func _init() -> void:
	if _instance:
		push_error("There is more than one OptionsUI instance")
	_instance = self

func _ready() -> void:
	UpdateVisual()
	
	soundEffectsButton.pressed.connect(func(): 
		audio.play()
		SoundManager.ChangeVolume() 
		UpdateVisual()
	)
	
	musicButton.pressed.connect(func(): 
		audio.play()
		MusicManager.ChangeVolume()
		UpdateVisual()
	)
	
	closeButton.pressed.connect(func(): 
		audio.play()
		hide()
		if _onCloseButtonAction.is_valid():
			_onCloseButtonAction.call()
	)

func _KitchenGameManager_OnGameUnpaused() -> void:
	hide()

func _exit_tree() -> void:
	if _instance == self:
		_instance = null

func UpdateVisual() -> void:
	if SoundManager:
		soundEffectsButton.text = "Sound Effects: " + str(round(SoundManager.GetVolume() * 10))
	
	if MusicManager:
		musicButton.text = "Music: " + str(round(MusicManager.GetVolume() * 10))

func Show(onCloseButtonAction: Callable) -> void:
	_onCloseButtonAction = onCloseButtonAction
	UpdateVisual()
	show()
	soundEffectsButton.grab_focus()
	
	

#hover mouse on buttons
func _on_sound_effects_button_mouse_entered():
	Input.set_custom_mouse_cursor(load("res://cursor_2_hover.png"))
func _on_sound_effects_button_mouse_exited():
	Input.set_custom_mouse_cursor(load("res://cursor_1.png"))
func _on_music_button_mouse_entered():
	Input.set_custom_mouse_cursor(load("res://cursor_2_hover.png"))
func _on_music_button_mouse_exited():
	Input.set_custom_mouse_cursor(load("res://cursor_1.png"))
func _on_close_button_mouse_entered():
	Input.set_custom_mouse_cursor(load("res://cursor_2_hover.png"))
func _on_close_button_mouse_exited():
	Input.set_custom_mouse_cursor(load("res://cursor_1.png"))
