extends PathFollow3D

## The Speed at which the enemy is walk every second
@export var speed: float = 2.5
@onready var base = get_tree().get_first_node_in_group("base")
@export var max_health : int = 50
@export var gold_value : int = 15
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var bank = get_tree().get_first_node_in_group("bank")

var current_health : int:
	set(health_in):
		if health_in < current_health:
			animation_player.play("TakeDamage")
		current_health = health_in
		if current_health < 1:
			bank.gold += gold_value
			queue_free()
			
func _ready() -> void:
	current_health = max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += delta * speed
	
	if progress_ratio >= 1.0:
		base.take_damage()
		set_process(false)
		queue_free()
