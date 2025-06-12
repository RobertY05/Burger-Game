extends Topping

const _scaling = 5

static var times_played = 0

func _init():
	topping_name = "Monterey Jack"
	topping_type = types.CHEESE
	height = 5
	rarity = tiers.COMMON
	cost = 30

func calculate(topping_list : Array[Topping], game_controller : GameController):
	game_controller.add_points(times_played * _scaling)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	times_played += 1

func get_description():
	return "+%d points for every 'Monterey Jack' played this run. \n'%s' will earn at least %d points." % [_scaling, topping_name, times_played * 5] 

func reset():
	times_played = 0
