extends Topping

func _init():
	topping_name = "Onion Rings"
	topping_type = types.OTHER
	height = 5
	rarity = tiers.UNCOMMON
	cost = 15

func calculate(topping_list : Array[Topping], game_controller : GameController):
	game_controller.add_points(125)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	game_controller.set_mode(game_controller.modes.SHUFFLE, 2)

func get_description():
	return "+75 points when graded. \n The next 2 cards you play will be shuffled randomly into your draw pile."
