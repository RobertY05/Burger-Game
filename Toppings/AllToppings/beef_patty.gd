extends Topping

func _init():
	topping_name = "Beef Patty"
	topping_type = "Protein"
	height = 10
	rarity = tiers.COMMON
	cost = 3

func calculate(topping_list : Array[Topping], game_controller : GameController):
	game_controller.add_points(25)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "+25 points when graded."
