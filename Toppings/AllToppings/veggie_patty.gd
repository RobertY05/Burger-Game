extends Topping

func _init():
	topping_name = "Veggie Patty"
	topping_type = types.VEGETABLE
	height = 10
	rarity = tiers.UNCOMMON
	cost = 15

func calculate(topping_list : Array[Topping], game_controller : GameController):
	game_controller.add_points(20)
	var protein = false
	for i in range(topping_list.size()):
		if topping_list[i].topping_type == types.PROTEIN:
			topping_list[i].flash()
			protein = true
	
	if not protein:
		game_controller.add_points(80)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "+20 points when graded. \n Additional +80 points if burger has no 'Protein' cards when graded."
