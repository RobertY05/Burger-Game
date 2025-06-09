extends Topping

func _init():
	topping_name = "Fish"
	topping_type = "Protein"
	height = 10
	rarity = tiers.UNCOMMON
	cost = 15

func calculate(topping_list : Array[Topping], game_controller : GameController):
	for i in range(topping_list.size()):
		if topping_list[i].topping_type == "Other":
			game_controller.add_points(75)
			topping_list[i].flash()

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "+75 points for every 'Other' type card played."
