extends Topping

const _flat_points = 25

func _init():
	topping_name = "Beef Patty"
	topping_type = types.PROTEIN
	height = 10
	rarity = tiers.COMMON
	cost = 3

func calculate(topping_list : Array[Topping], game_controller : GameController):
	game_controller.add_points(_flat_points)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "+%d points when graded." % _flat_points
