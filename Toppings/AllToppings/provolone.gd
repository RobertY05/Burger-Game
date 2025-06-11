extends Topping

var points_to_award = 10

func _init():
	topping_name = "Provolone"
	topping_type = types.CHEESE
	height = 5
	rarity = tiers.UNCOMMON
	cost = 40

func calculate(topping_list : Array[Topping], game_controller : GameController):
	for i in range(topping_list.size()):
		if topping_list[i].topping_type == types.CHEESE:
			points_to_award += 1
			topping_list[i].flash()
	
	game_controller.add_points(points_to_award)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "+10 points when graded. \n Permanently buff this card by 1 point for every 'Cheese' type card in the burger when graded. \n Currently at " + str(points_to_award) + " points."
