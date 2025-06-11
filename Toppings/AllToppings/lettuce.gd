extends Topping

func _init():
	topping_name = "Lettuce"
	topping_type = types.VEGETABLE
	height = 3
	rarity = tiers.COMMON
	cost = 5

func calculate(topping_list : Array[Topping], game_controller : GameController):
	pass

func on_play(topping_list : Array[Topping], game_controller : GameController):
	game_controller.draw_card(2)

func get_description():
	return "Draw 2 cards when played."
