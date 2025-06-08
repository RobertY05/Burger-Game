extends Topping

var points_to_add = 0

func _init():
	topping_name = "Tiny Horse"
	topping_type = "Protein"
	height = 80
	rarity = tiers.RARE
	cost = 45

func calculate(topping_list : Array[Topping], game_controller : GameController):
	var my_idx = topping_list.find(self)
	var eat_to = my_idx
	var eaten = 0
	for i in range(my_idx - 1, -1, -1):
		if topping_list[i].topping_type != "Vegetable":
			break
		eat_to = i
		eaten += 1
	
	var offset = 0
	for i in range(eaten):
		offset += topping_list[eat_to].height
		game_controller.burger.remove_child(topping_list.pop_at(eat_to))
		points_to_add += 10
	
	for i in range(eat_to, topping_list.size()):
		topping_list[i].desired_position.y += offset
	
	if eat_to == 0 and game_controller.burger.calculation_idx != 0:
		desired_position.y += game_controller.burger.peek_offset

	game_controller.burger.calculation_idx -= eaten
	game_controller.add_points(points_to_add)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "Eats all 'Vegetable' type cards that it can stand on when graded. \n +10 points for every 'Vegetable' type card it has eaten this run. \n Currently at " + str(points_to_add) + " points."
