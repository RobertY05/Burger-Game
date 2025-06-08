extends Topping

func _init():
	topping_name = "Chicken"
	topping_type = "Protein"
	height = 10
	rarity = tiers.COMMON
	cost = 20

func calculate(topping_list : Array[Topping], game_controller : GameController):
	game_controller.multiply_points(1.5)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "x1.2 points when graded"
