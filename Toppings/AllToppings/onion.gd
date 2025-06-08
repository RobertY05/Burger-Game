extends Topping

func _init():
	topping_name = "Onion"
	topping_type = "Vegetable"
	height = 5
	rarity = tiers.COMMON
	cost = 9

func calculate(topping_list : Array[Topping], game_controller : GameController):
	pass

func on_play(topping_list : Array[Topping], game_controller : GameController):
	game_controller.play_mode = game_controller.modes.BOTTOM
	game_controller.play_mode_count = 2
	game_controller.draw_card(3)

func get_description():
	return "Draw 3 card. \n The next 2 cards you play will be sent to the bottom of your draw pile."
