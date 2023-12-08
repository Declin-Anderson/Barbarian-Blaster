extends MarginContainer

# The amount of gold the player starts with for the level
@export var starting_gold := 150
# Reference to the label that tells the player how much gold they have
@onready var label: Label = $Label

# Setter for the gold variable that is current amount the player has
var gold : int:
	# Sets the gold equal to the new value and updates the label to display the new total
	set(gold_in):
		gold = max(gold_in, 0)
		label.text = "gold: " + str(gold)

# When the game starts the gold variable is set to the starting gold
func _ready() -> void:
	gold = starting_gold
