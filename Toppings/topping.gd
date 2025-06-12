class_name Topping
extends Node2D

# ----- stats -----

enum types {PROTEIN, CHEESE, VEGETABLE, SAUCE, OTHER}
var topping_type : types
var topping_name = "Undefined"

# height in pixels
var height = 10

# higher value is rarer
enum tiers {COMMON, UNCOMMON, RARE}
var rarity = tiers.COMMON
var cost = 10

var desired_position = Vector2.ZERO
var _lerp_speed = 0.4

# ----- stats -----

signal stats_changed

func get_image():
	return $Sprite2D.texture

func type_to_string(type):
	if type == types.PROTEIN:
		return "Protein"
	elif type == types.CHEESE:
		return "Cheese"
	elif type == types.VEGETABLE:
		return "Vegetable"
	elif type == types.SAUCE:
		return "Sauce"
	elif type == types.OTHER:
		return "Other"
	else:
		return "Unknown Type"

# for every topping, define these functions, by default they do nothing:
func calculate(topping_list, game_controller):
	var my_idx = topping_list.find(self)
	for i in range(my_idx):
		topping_list[i].flash()
	game_controller.set_points(game_controller.get_points() + my_idx)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	game_controller.draw_card()

func get_description():
	return "gain 1 point for every topping played below this topping\n if you are playing the real game you should not see this!!!"

func reset():
	return

func flash():
	modulate = Color(4, 4, 4)

func bounce():
	scale = Vector2(1.5, 2)

func _physics_process(delta):
	global_position = lerp(global_position, desired_position, _lerp_speed)
	modulate = lerp(modulate, Color(1, 1, 1, 1), _lerp_speed)
	scale = lerp(scale, Vector2(1, 1), _lerp_speed)
