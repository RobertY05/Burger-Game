extends Topping

func _init():
	topping_name = "Tomato"
	topping_type = types.VEGETABLE
	height = 5
	rarity = tiers.COMMON
	cost = 7

func calculate(topping_list : Array[Topping], game_controller : GameController):
	pass

func on_play(topping_list : Array[Topping], game_controller : GameController):
	game_controller.add_points(15)
	game_controller.draw_card(1)

func get_description():
	return "+15 points when played. \n Draw a card."
