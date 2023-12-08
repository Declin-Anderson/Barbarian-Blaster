extends Node3D

# Max amount of health the base has before the enemies destroy it
@export var max_health: int = 5
# Reference to the label that holds the health of the base
@onready var label_3d: Label3D = $Label3D

# Setter for the current health of the base
var current_health: int:
	# Sets the health of base to the new value when an enemy enters
	set(health_in):
		current_health = health_in
		# Updates the label over the base that tells it health and changes color the more damage it takes
		label_3d.text = str(current_health) + "/" + str(max_health)
		var red: Color = Color.RED
		var white: Color = Color.WHITE
		var blendedcolor = red.lerp(white, float(current_health) / float(max_health))
		label_3d.modulate = blendedcolor
		# If the health of the base is 0 it restarts the level
		if current_health < 1:
			get_tree().reload_current_scene()

# Sets the health of the base to the max amount possible when the game starts
func _ready() -> void:
	current_health = max_health

# Reduces the health of the base when it takes damage
func take_damage() -> void:
	current_health -= 1
