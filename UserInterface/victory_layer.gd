extends CanvasLayer

# Reference to the first star for determining how well the player did
@onready var star_1: TextureRect = %Star1
# Reference to the second star for determining how well the player did
@onready var star_2: TextureRect = %Star2
# Reference to the third star for determining how well the player did
@onready var star_3: TextureRect = %Star3
# Reference to the label that tells the player they have passed with enough health on the base
@onready var health_label: Label = %HealthLabel
# Reference to the label that tells the player they have passed with enough extra money in their bank
@onready var money_label: Label = %MoneyLabel
# Reference to the base that the victory checks for current health progress
@onready var base = get_tree().get_first_node_in_group("base")
# Reference to the bank that the victory checks for current amount of money
@onready var bank = get_tree().get_first_node_in_group("bank")

# When the user has won the level its checks win conditions for stars
func victory() -> void:
	visible = true
	# If the base took no damage thats a star
	if base.max_health == base.current_health:
		star_2.modulate = Color.WHITE
		health_label.visible = true
	# If the player ended with extra money in the bank
	if bank.gold >= 500:
		star_3.modulate = Color.WHITE
		money_label.visible = true

# The player chooses to do the level again for better score or fun
func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()

# The player chooose to leave the game
func _on_quit_button_pressed() -> void:
	get_tree().quit()
