extends Topping

func _init():
	topping_name = "Swiss Cheese"
	topping_type = "Cheese"
	height = 5
	rarity = tiers.COMMON
	cost = 8

func calculate(topping_list : Array[Topping], game_controller : GameController):
	var my_idx = topping_list.find(self)
	var count = 0
	var found = false
	for i in range(my_idx - 1, -1, -1):
		if topping_list[i].topping_name == topping_name:
			topping_list[i].flash()
			found = true
			break
		count += 20
	if found:
		game_controller.add_points(count)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "+20 points for every topping played between two 'Swiss Cheese'."
