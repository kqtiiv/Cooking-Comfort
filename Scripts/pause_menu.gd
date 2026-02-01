extends Control
class_name PauseMenu

@export var resumeButton: Button
@export var restartButton: Button
@export var settingsButton: Button
@export var quitButton: Button

@onready var audio: AudioStreamPlayer = $Panel/Content/button_click
@onready var animation: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide() 
	
	resumeButton.pressed.connect(_on_resume_pressed)
	restartButton.pressed.connect(_on_restart_pressed)
	settingsButton.pressed.connect(_on_settings_pressed)
	quitButton.pressed.connect(_on_quit_pressed)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		if get_tree().paused:
			OptionsUI.hide()
			resume()
		else:
			pause()

func pause() -> void:
	get_tree().paused = true
	show() 
	animation.play("blur")
	resumeButton.grab_focus()

func resume() -> void:
	get_tree().paused = false
	animation.play_backwards("blur")
	await animation.animation_finished 
	if not get_tree().paused: 
		hide() 

func _on_resume_pressed() -> void:
	audio.play()
	resume()

func _on_restart_pressed() -> void:
	audio.play()
	resume()
	GameManager.reset_game_state()
	get_tree().reload_current_scene()

func _on_settings_pressed() -> void:
	audio.play()
	hide() 
	OptionsUI.Show(_onOptionsClosed)

func _on_quit_pressed() -> void:
	audio.play()
	await get_tree().create_timer(0.25).timeout
	get_tree().quit()

func _onOptionsClosed() -> void:
	show()
	resumeButton.grab_focus()
	


#hover mouse!!!
func _on_resume_mouse_entered():
	Input.set_custom_mouse_cursor(load("res://cursor_2_hover.png"))
func _on_resume_mouse_exited():
	Input.set_custom_mouse_cursor(load("res://cursor_1.png"))
func _on_restart_mouse_entered():
	Input.set_custom_mouse_cursor(load("res://cursor_2_hover.png"))
func _on_restart_mouse_exited():
	Input.set_custom_mouse_cursor(load("res://cursor_1.png"))
func _on_settings_mouse_entered():
	Input.set_custom_mouse_cursor(load("res://cursor_2_hover.png"))
func _on_settings_mouse_exited():
	Input.set_custom_mouse_cursor(load("res://cursor_1.png"))
func _on_quit_mouse_entered():
	Input.set_custom_mouse_cursor(load("res://cursor_2_hover.png"))
func _on_quit_mouse_exited():
	Input.set_custom_mouse_cursor(load("res://cursor_1.png"))
