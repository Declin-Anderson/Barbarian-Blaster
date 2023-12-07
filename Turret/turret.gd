extends Node3D

@export var projectile: PackedScene
@export var turret_range: float = 10.0
@onready var barrel: MeshInstance3D = $TurretBase/TurretTop/Visor/Barrel
var enemy_path: Path3D
var target: PathFollow3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _physics_process(delta: float) -> void:
	target = find_best_target()
	if target:
		look_at(target.global_position, Vector3.UP, true)

func _on_timer_timeout() -> void:
	if target:
		var shot = projectile.instantiate()
		add_child(shot)
		shot.global_position = barrel.global_position
		shot.direction = global_transform.basis.z
		animation_player.play("fire")

func find_best_target() -> PathFollow3D:
	var best_target = null
	var best_progress = 0
	for enemy in enemy_path.get_children():
		if enemy is PathFollow3D:
			if enemy.progress > best_progress:
				var distance := global_position.distance_to(enemy.global_position)
				if distance <= turret_range:
					best_progress = enemy.progress
					best_target = enemy
	return best_target
