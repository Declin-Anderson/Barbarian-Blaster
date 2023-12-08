extends Node

# Signal to use when the enemies need to stop spawning
signal stop_spawning_enemies

# Length of the game in seconds
@export var game_length := 180.0
# Variable that holds the curve that determines the spawning of enemies
@export var spawn_time_curve: Curve
# Variable that holds the curve that determines the health of the enemies spawning
@export var enemy_health_curve: Curve
# Reference to the Timer used to countdown the level time
@onready var timer: Timer = $Timer

# Starts the timer for the level
func _ready() -> void:
	timer.start(game_length)

# Gets the ratio of how far the player has gone through the level
func game_progress_ratio() -> float:
	return 1.0 - (timer.time_left / game_length)

# Gets the current value of the spawn curve
func get_spawn_time() -> float:
	return spawn_time_curve.sample(game_progress_ratio())

# Gets the current value of the health that new enemies will spawn at
func get_enemy_health() -> float:
	return enemy_health_curve.sample(game_progress_ratio())

# Stops spawning enemies when the timer has run out
func _on_timer_timeout() -> void:
	stop_spawning_enemies.emit()
