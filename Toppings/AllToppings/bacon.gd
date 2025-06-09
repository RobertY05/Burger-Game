extends Topping

func _init():
	topping_name = "Bacon"
	topping_type = "Protein"
	height = 5
	rarity = tiers.COMMON
	cost = 18

func calculate(topping_list : Array[Topping], game_controller : GameController):
	game_controller.add_points(50)
	var my_idx = topping_list.find(self)
	for i in range(my_idx + 1, topping_list.size()):
		if topping_list[i].topping_name == "Egg":
			topping_list[i].flash()
			game_controller.add_points(25)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "+50 points when graded. \n Additional +25 points for every 'Egg' placed above this topping."
