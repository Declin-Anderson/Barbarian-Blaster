extends Area3D

# Direction that the projectile will fire
var direction := Vector3.FORWARD

# Speed at which the projectile moves
@export var speed:= 30.0
# Damage that the turret will do
@export var damage := 25

# Moves the projectile in the direction that it is suppose to move to
func _physics_process(delta: float) -> void:
	position += direction * speed * delta

# When the projectile has gone too far it is removed from the scene to clean up space
func _on_timer_timeout() -> void:
	queue_free()

# When the projectile enters an enemy collision zone its does the damage and then removes its self from the scene
func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("enemy_area"):
		area.get_parent().current_health -= damage
		queue_free()
