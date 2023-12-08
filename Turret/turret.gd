extends Node3D

# Gets the projectile scene for the turrets to fire
@export var projectile: PackedScene
# Range that the turrets have
@export var turret_range: float = 10.0
# Path that the enemies follow
var enemy_path: Path3D
# Target of the current turret
var target: PathFollow3D
# Reference to the top of the turret for animations
@onready var turret_top: Node3D = $TurretBase/TurretTop
# Reference to the cannon that is mounted to the tower
@onready var cannon: Node3D = $TurretBase/TurretTop/Cannon
# Reference to the base of the turret that moves to aim
@onready var turret_base: Node3D = $TurretBase
# Reference to the animation player that the turret uses
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Finds the best target for the turret and makes the cannon look at the targeted enemy
func _physics_process(delta: float) -> void:
	target = find_best_target()
	if target:
		turret_base.look_at(target.global_position, Vector3.UP, true)

# When the turret has had enough time to reload it shots a shot at its target
func _on_timer_timeout() -> void:
	if target:
		# Creates a new projectile and aims the tower at the enemy to play its animation
		var shot = projectile.instantiate()
		add_child(shot)
		shot.global_position = cannon.global_position
		shot.direction = turret_base.global_transform.basis.z
		animation_player.play("fire")

# Finds the best target for the turret to shot
func find_best_target() -> PathFollow3D:
	# The target that the turret will shot at
	var best_target = null
	# The furthest progressed enemy
	var best_progress = 0
	for enemy in enemy_path.get_children():
		if enemy is PathFollow3D:
			# if the enemy is currently progressed further than the previous checked enemy update the best target
			if enemy.progress > best_progress:
				var distance := global_position.distance_to(enemy.global_position)
				if distance <= turret_range:
					best_progress = enemy.progress
					best_target = enemy
	return best_target
