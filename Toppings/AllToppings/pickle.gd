extends Topping

func _init():
	topping_name = "Pickle"
	topping_type = "Vegetable"
	height = 5
	rarity = tiers.COMMON
	cost = 3

func calculate(topping_list : Array[Topping], game_controller : GameController):
	pass

func on_play(topping_list : Array[Topping], game_controller : GameController):
	game_controller.draw_card()
	for i in range(topping_list.size()):
		if topping_list[i].topping_name == "Pickle":
			game_controller.draw_card()
			topping_list[i].flash()

func get_description():
	return "Draw a card for every 'Pickle' played this burger."
