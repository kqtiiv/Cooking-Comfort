extends Control

@export var message_label: Label
@export var message_label_2: Label
@export var result_image: TextureRect

@export var perfect_image: Texture2D
@export var good_image: Texture2D
@export var bad_image: Texture2D

@onready var audio = $button_click

func _ready():
	calculate_and_display()

func calculate_and_display():
	var score = 0
	var total_npcs = GameManager.npc_emotions.size()
	
	# Calculate score
	for i in range(total_npcs):
		if i >= GameManager.correct_emotions.size():
			break
			
		var player_choice = GameManager.npc_emotions[i]
		var correct_answer = GameManager.correct_emotions[i]
		
		if player_choice == correct_answer:
			score += 1
			print([i+1])
		else:
			print([i+1, player_choice, correct_answer])

	
	# Show Image & Message based on performance
	if score == total_npcs:
		message_label.text = "Congratulations. You're now a certified empath!!"
		message_label_2.text = "The cafe went on to become internet famous. Guy Fieri teared up when he visited. You got a handshake from Paul Hollywood. Even Gordan Ramsey approved!"
		if perfect_image: result_image.texture = perfect_image
		
	elif score >= 1:
		message_label.text = "Okay so you've worked customer service before"
		message_label_2.text = "Your place is definitely a town favorite! People comment on how friendly and quick the service is. Your parents are proud of how far you've come."
		if good_image: result_image.texture = good_image
		
	else:
		message_label.text = "You're a REALLY bad listener.... that's just sad :("
		message_label_2.text = "Hoards of bad reviews flooded the cafe's Yelp page so you closed that day out of sheer embarrassment. I think it's time you find a new line of work."
		if bad_image: result_image.texture = bad_image

func _on_restart_pressed():
	GameManager.npcs_served = 0
	GameManager.npc_emotions.clear()
	GameManager.current_step = GameManager.CookingStep.TALK_TO_CUSTOMER
	
	SceneTransition.change_scene_to_file("res://Scenes/MainLevel.tscn")


func _on_credits_pressed():
	audio.play()
	await get_tree().create_timer(0.25).timeout
	SceneTransition.change_scene_to_file("res://Scenes/Credits.tscn")


func _on_exit_pressed():
	audio.play()
	await get_tree().create_timer(0.25).timeout 
	get_tree().quit()
	


func _on_restart_mouse_entered():
	Input.set_custom_mouse_cursor(load("res://cursor_2_hover.png"))

func _on_restart_mouse_exited():
	Input.set_custom_mouse_cursor(load("res://cursor_1.png"))


func _on_credits_mouse_entered():
	Input.set_custom_mouse_cursor(load("res://cursor_2_hover.png"))


func _on_credits_mouse_exited():
	Input.set_custom_mouse_cursor(load("res://cursor_2_hover.png"))


func _on_exit_mouse_entered():
	Input.set_custom_mouse_cursor(load("res://cursor_2_hover.png"))


func _on_exit_mouse_exited():
	Input.set_custom_mouse_cursor(load("res://cursor_2_hover.png"))
