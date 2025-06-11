extends Topping

func _init():
	topping_name = "Goat Cheese"
	topping_type = types.CHEESE
	height = 10
	rarity = tiers.RARE
	cost = 25

func calculate(topping_list : Array[Topping], game_controller : GameController):
	if randi_range(1, 3) == 1:
		game_controller.add_points(500)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "1 in 3 chance to give +500 points."
