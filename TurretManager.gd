extends Node3D

# The turrets that the manager will look over
@export var turret: PackedScene
# The path that the enemies take to the base the turret will look over
@export var enemy_path: Path3D

# Builds a turret on the tile and sets the position and what enemy path the turret will be at
func build_turret(turret_position: Vector3) -> void:
	var new_turret = turret.instantiate()
	add_child(new_turret)
	new_turret.global_position = turret_position
	new_turret.enemy_path = enemy_path
