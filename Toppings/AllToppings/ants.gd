extends Topping

func _init():
	topping_name = "Ants"
	topping_type = "Protein"
	height = 1
	rarity = tiers.RARE
	cost = 40

func calculate(topping_list : Array[Topping], game_controller : GameController):
	topping_list.shuffle()
	var new_pos = 0
	for i in range(topping_list.size()):
		game_controller.burger.remove_child(topping_list[i])
		game_controller.burger.add_child(topping_list[i])
		topping_list[i].desired_position.y = new_pos
		new_pos -= topping_list[i].height
	
	game_controller.burger.remove_child(game_controller.burger.top_bun)
	game_controller.burger.add_child(game_controller.burger.top_bun)
	
	var my_idx = topping_list.find(self)
	game_controller.burger.calculation_idx = my_idx
	
	for i in range(game_controller.burger.calculation_idx, topping_list.size()):
		topping_list[i].desired_position.y -= game_controller.burger.peek_offset

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "Shuffles the burger when graded. \n Continue grading from this ingredient after shuffling."
