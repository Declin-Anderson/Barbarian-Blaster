extends PathFollow3D

## The Speed at which the enemy is walk every second
@export var speed: float = 2.5
# Reference to the base scene
@onready var base = get_tree().get_first_node_in_group("base")
# Max Health of the enemy
@export var max_health : int = 50
# How much gold the enemy is worth
@export var gold_value : int = 15
# Reference to the animation player of the enemy
@onready var animation_player: AnimationPlayer = $AnimationPlayer
# Reference to the bank scene
@onready var bank = get_tree().get_first_node_in_group("bank")

# Setter for the current health of the enemy
var current_health : int:
	set(health_in):
		# When the enemy takes damage it plays the take damage animation
		if health_in < current_health:
			animation_player.play("TakeDamage")
		current_health = health_in
		# If the enemy dies, reward the player with gold depending on the enemy
		if current_health < 1:
			bank.gold += gold_value
			queue_free()

# Sets the current health of the enemy to the max when it spawns
func _ready() -> void:
	current_health = max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Progress the enemy along the path towards the base
	progress += delta * speed
	
	# If the enemy reaches the base it is removed and the base is damaged
	if progress_ratio >= 1.0:
		base.take_damage()
		set_process(false)
		queue_free()
