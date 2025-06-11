extends Topping

func _init():
	topping_name = "Ants"
	topping_type = types.OTHER
	height = 1
	rarity = tiers.RARE
	cost = 40

func calculate(topping_list : Array[Topping], game_controller : GameController):
	var new_list = []
	var new_pos = 0
	for i in range(topping_list.size()):
		new_list.push_back(topping_list[topping_list.size() - 1])
		game_controller.burger.destroy_topping(topping_list.size() - 1)
	
	new_list.shuffle()
	var my_idx = new_list.find(self)
	game_controller.burger.change_idx(my_idx)
	
	for i in range(new_list.size()):
		game_controller.burger.insert_topping(i, new_list[i])
		new_list[i].flash()
	
	

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "Shuffles the burger when graded. \nContinue grading from this ingredient after shuffling."
