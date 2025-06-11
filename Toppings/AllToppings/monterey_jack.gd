extends Topping

static var times_played = 0

func _init():
	topping_name = "Monterey Jack"
	topping_type = types.CHEESE
	height = 5
	rarity = tiers.COMMON
	cost = 30

func calculate(topping_list : Array[Topping], game_controller : GameController):
	game_controller.add_points(times_played * 5)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	times_played += 1

func get_description():
	return "+5 points for every 'Monterey Jack' played this run. \n 'Monterey Jack' earns " + str(times_played * 5) + " points." 

func reset():
	times_played = 0
