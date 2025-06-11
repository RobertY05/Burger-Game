extends Topping

const _combo_points = 5
const _combo_type = types.CHEESE

func _init():
	topping_name = "Cheddar"
	topping_type = types.CHEESE
	height = 5
	rarity = tiers.COMMON
	cost = 6

func calculate(topping_list : Array[Topping], game_controller : GameController):
	var points_to_add = 0
	for i in range(topping_list.size()):
		if topping_list[i].topping_type == _combo_type:
			topping_list[i].flash()
			points_to_add += _combo_points
	
	game_controller.add_points(points_to_add)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "When graded, +%d points for every '%s' type card played this burger." % [_combo_points, type_to_string(_combo_type)]
