extends Camera3D

# The gridmap that the ray cast will be pointing at
@export var gridmap: GridMap
# Gets the turrets that are currently on the map
@export var turret_manager: Node3D
# Cost of the turret to build it
@export var turret_cost := 100

# Reference to the ray cast object on the camera
@onready var ray_cast_3d: RayCast3D = $RayCast3D
# Reference to the bank for when a turret is purchased
@onready var bank = get_tree().get_first_node_in_group("bank")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Gets the current that the mouse is in the scene
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	ray_cast_3d.target_position = project_local_ray_normal(mouse_position) * 100.0
	ray_cast_3d.force_raycast_update()
	
	# If the raycast is colliding with an object in the scene
	if ray_cast_3d.is_colliding():
		# If the player has enough gold to purchase a turret
		if bank.gold >= turret_cost:
			# Updates the cursor to alert the user they can click and gets what the collider is colliding with
			Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
			var collider = ray_cast_3d.get_collider()
			if collider is GridMap:
				# If the user clicks
				if Input.is_action_pressed("click"):
					var collision_point = ray_cast_3d.get_collision_point()
					var cell = gridmap.local_to_map(collision_point)
					# If the user clicked an open turret tile it fills it with a turret and spends the gold
					if gridmap.get_cell_item(cell) == 0:
						gridmap.set_cell_item(cell, 1)
						var tile_position = gridmap.map_to_local(cell)
						turret_manager.build_turret(tile_position)
						bank.gold -= turret_cost
		else:
			# The player doesn't have enough gold to spawn a turret
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	else:
		# The User is not colliding with any collision zones
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
