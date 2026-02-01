extends Node3D

@export var npc_scene: PackedScene
@export var paths: Array[Path3D]
@onready var door_anim: AnimationPlayer = $World/Hinge/AnimationPlayer

func _ready():
	GameManager.request_next_npc.connect(spawn_npc)
	if GameManager.npcs_served == 0:
		spawn_npc()

func spawn_npc():
	var current_index = GameManager.npcs_served
	if current_index >= paths.size(): return

	var target_path = paths[current_index]
	var new_npc = npc_scene.instantiate()
	target_path.add_child(new_npc)

	target_path.get_node("PathFollow/Interact").setup_new_npc(new_npc)
	
	$World/doorbell.play()
	door_anim.play("open")
	
	new_npc.progress_ratio = 0.0
	
	# Remove the old NPC from the previous path
	var old_path = paths[GameManager.npcs_served - 1]
	for child in old_path.get_children():
		child.queue_free()
