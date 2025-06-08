extends Topping

func _init():
	topping_name = "Cheddar"
	topping_type = "Cheese"
	height = 5
	rarity = tiers.COMMON
	cost = 6

func calculate(topping_list : Array[Topping], game_controller : GameController):
	for i in range(topping_list.size()):
		if topping_list[i].topping_type == "Cheese":
			topping_list[i].flash()
			game_controller.add_points(5)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "When graded, +5 points for every 'Cheese' type card played this burger."
