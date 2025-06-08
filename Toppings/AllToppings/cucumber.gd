extends Topping

func _init():
	topping_name = "Cucumber"
	topping_type = "Vegetable"
	height = 5
	rarity = tiers.COMMON
	cost = 3

func calculate(topping_list : Array[Topping], game_controller : GameController):
	pass

func on_play(topping_list : Array[Topping], game_controller : GameController):
	var count = 4
	for i in range(topping_list.size()):
		if topping_list[i].topping_name == "Pickle":
			count -= 1
			topping_list[i].flash()
	if count > 0:
		game_controller.draw_card(4)

func get_description():
	return "Draw 4 cards. \n For every 'Pickle' played this burger draw 1 less card."
