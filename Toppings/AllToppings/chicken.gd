extends Topping

const _flat_multiplier = 1.5

func _init():
	topping_name = "Chicken"
	topping_type = types.PROTEIN
	height = 10
	rarity = tiers.COMMON
	cost = 20

func calculate(topping_list : Array[Topping], game_controller : GameController):
	game_controller.multiply_points(_flat_multiplier)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "x%0.2f points when graded" % _flat_multiplier
