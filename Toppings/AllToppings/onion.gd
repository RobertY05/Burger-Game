extends Topping

func _init():
	topping_name = "Onion"
	topping_type = "Vegetable"
	height = 5
	rarity = tiers.COMMON
	cost = 6

func calculate(topping_list : Array[Topping], game_controller : GameController):
	pass

func on_play(topping_list : Array[Topping], game_controller : GameController):
	game_controller.set_mode(game_controller.modes.BOTTOM, 2)
	game_controller.draw_card(3)

func get_description():
	return "Draw 3 cards. \n The next 2 cards you play will be sent to the bottom of your draw pile."
