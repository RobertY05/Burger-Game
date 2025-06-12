extends Topping

const flat_mult = 2

func _init():
	topping_name = "Bear Trap"
	topping_type = types.OTHER
	height = 70
	rarity = tiers.COMMON
	cost = 3

func calculate(topping_list : Array[Topping], game_controller : GameController):
	game_controller.multiply_points(flat_mult)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "x%0.2f points when graded." % flat_mult
