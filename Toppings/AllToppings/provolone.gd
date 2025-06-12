extends Topping

const _starting_points = 10
const _scaling = 1
const _combo_type = types.CHEESE

var _points_to_award = _starting_points

func _init():
	topping_name = "Provolone"
	topping_type = types.CHEESE
	height = 5
	rarity = tiers.UNCOMMON
	cost = 40

func calculate(topping_list : Array[Topping], game_controller : GameController):
	for i in range(topping_list.size()):
		if topping_list[i].topping_type == _combo_type:
			_points_to_award += _scaling
			topping_list[i].flash()
	
	game_controller.add_points(_points_to_award)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "+%d points when graded. \nPermanently buff this card by %d point for every '%s' type card in the burger when graded. \nCurrently at +%d points." % [_starting_points, _scaling, type_to_string(_combo_type), _points_to_award]
