extends Control

@export var playButton: Button
@export var optionsButton: Button
@export var quitButton: Button
@onready var audio = $MainMenuUI/button_click

func _ready() -> void:
	playButton.grab_focus()
	
	playButton.pressed.connect(func(): 
		audio.play()
		await get_tree().create_timer(0.25).timeout
		SceneTransition.change_scene_to_file("res://Scenes/MainLevel.tscn"))
	
	
	optionsButton.pressed.connect(func(): 
		audio.play()
		hide()
		OptionsUI.Show(show)
	)
	
	quitButton.pressed.connect(func():
		audio.play()
		await get_tree().create_timer(0.25).timeout 
		get_tree().quit())
	

	Engine.time_scale = 1.0
	
	
func _on_start_mouse_entered():
	Input.set_custom_mouse_cursor(load("res://cursor_2_hover.png"))

func _on_start_mouse_exited():
	Input.set_custom_mouse_cursor(load("res://cursor_1.png"))

func _on_settings_mouse_entered():
	Input.set_custom_mouse_cursor(load("res://cursor_2_hover.png"))

func _on_settings_mouse_exited():
	Input.set_custom_mouse_cursor(load("res://cursor_1.png"))

func _on_exit_mouse_entered():
	Input.set_custom_mouse_cursor(load("res://cursor_2_hover.png"))

func _on_exit_mouse_exited():
	Input.set_custom_mouse_cursor(load("res://cursor_1.png"))
