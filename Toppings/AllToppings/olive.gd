extends Topping

func _init():
	topping_name = "Olive"
	topping_type = "Vegetable"
	height = 3
	rarity = tiers.COMMON
	cost = 7

func calculate(topping_list : Array[Topping], game_controller : GameController):
	game_controller.draw_card(3)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "Draw 3 cards when graded."
