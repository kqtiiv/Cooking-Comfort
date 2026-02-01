extends Control

@export var Back: Button
@onready var audio: AudioStreamPlayer = $button_click

func _ready():
	Back.pressed.connect(func():
		audio.play()
		await get_tree().create_timer(0.25).timeout
		SceneTransition.change_scene_to_file("res://Scenes/ResultsScreen.tscn"))

#hover mouse
func _on_button_mouse_entered():
	Input.set_custom_mouse_cursor(load("res://cursor_2_hover.png"))
func _on_button_mouse_exited():
	Input.set_custom_mouse_cursor(load("res://cursor_1.png"))
