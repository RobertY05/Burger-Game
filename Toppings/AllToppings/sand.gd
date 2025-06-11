extends Topping

func _init():
	topping_name = "Sand"
	topping_type = types.OTHER
	height = 5
	rarity = tiers.RARE
	cost = -50

func calculate(topping_list : Array[Topping], game_controller : GameController):
	game_controller.add_points(-1)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "Lose 1 point when graded."
