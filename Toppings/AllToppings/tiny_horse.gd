extends Topping

var points_to_add = 0

func _init():
	topping_name = "Tiny Horse"
	topping_type = types.PROTEIN
	height = 80
	rarity = tiers.RARE
	cost = 45

func calculate(topping_list : Array[Topping], game_controller : GameController):
	var my_idx = topping_list.find(self)
	print(my_idx)
	for i in range(my_idx - 1, -1, -1):
		if topping_list[i].topping_type != types.VEGETABLE:
			break
		game_controller.burger.destroy_topping(i)
		points_to_add += 10
	game_controller.add_points(points_to_add)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "Removes all 'Vegetable' type toppings immediately below the horse when graded. \n +10 points for every 'Vegetable' type removed this run. \n Currently at " + str(points_to_add) + " points."
