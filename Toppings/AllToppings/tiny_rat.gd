extends Topping

const _scaling = 20
const _combo_type = types.CHEESE

var _points_to_add = 0

func _init():
	topping_name = "Tiny Rat"
	topping_type = types.PROTEIN
	height = 5
	rarity = tiers.RARE
	cost = 45

func calculate(topping_list : Array[Topping], game_controller : GameController):
	var my_idx = topping_list.find(self)
	for i in range(my_idx - 1, -1, -1):
		if topping_list[i].topping_type != _combo_type:
			break
		game_controller.burger.destroy_topping(i)
		_points_to_add += _scaling
	game_controller.add_points(_points_to_add)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "Removes all '%s' type toppings immediately below the horse when graded. \n+%d points for every '%s' type removed this run. \nCurrently at +%d points." % [type_to_string(_combo_type), _scaling, type_to_string(_combo_type), _points_to_add]
