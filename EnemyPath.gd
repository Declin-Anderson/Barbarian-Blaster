extends Path3D

# Gets the enemy that will be spawned on the path
@export var enemy_scene: PackedScene
# Gets the difficulty manager to determine the starting values of the enemies
@export var difficulty_manager: Node
# Gets the canvas to play the victory screen on when the player wins
@export var victory_layer: CanvasLayer
# Reference to the timer that is used to spawn the enemies
@onready var timer: Timer = $Timer

# Spawns the enemies at the start of the path to make their way to the base
func spawn_enemy() -> void:
	# Creates a new enemy with set health and adds it to the scene
	var new_enemy = enemy_scene.instantiate()
	new_enemy.max_health = difficulty_manager.get_enemy_health()
	add_child(new_enemy)
	timer.wait_time = difficulty_manager.get_spawn_time()
	new_enemy.tree_exited.connect(enemy_defeated)

# When the game hits the end of the play time it stop spawning the enemies
func _on_difficulty_manager_stop_spawning_enemies() -> void:
	timer.stop()

# When the last enemy has been defeated it plays the victory screen
func enemy_defeated() -> void:
	# If the timer has reached the end of the game length
	if timer.is_stopped():
		for child in get_children():
			if child is PathFollow3D:
				return
		victory_layer.victory()
