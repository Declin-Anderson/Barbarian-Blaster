extends PathFollow3D

## The Speed at which the enemy is walk every second
@export var speed: float = 2.5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += delta * speed
