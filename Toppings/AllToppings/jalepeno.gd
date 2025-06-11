extends Topping

func _init():
	topping_name = "Jalepeno"
	topping_type = types.VEGETABLE
	height = 1
	rarity = tiers.UNCOMMON
	cost = 7

func calculate(topping_list : Array[Topping], game_controller : GameController):
	game_controller.add_points(-5)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	game_controller.draw_card(5)

func get_description():
	return "Draw 5 cards when played. \n Lose 30 points when scored."
