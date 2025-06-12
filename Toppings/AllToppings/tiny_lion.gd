extends Topping

const _scaling = 0.05
const _combo_type = types.PROTEIN

var _points_to_mult = 1.0

func _init():
	topping_name = "Tiny Lion"
	topping_type = types.PROTEIN
	height = 60
	rarity = tiers.RARE
	cost = 60

func calculate(topping_list : Array[Topping], game_controller : GameController):
	var my_idx = topping_list.find(self)
	var needs_change = false
	for i in range(my_idx - 1, -1, -1):
		if topping_list[i].topping_type != _combo_type:
			break
		game_controller.burger.destroy_topping(i)
		_points_to_mult += _scaling
		needs_change = true
	game_controller.multiply_points(_points_to_mult)
	
	if needs_change:
		stats_changed.emit()

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "Removes all '%s' type toppings immediately below the lion when graded.\n+%0.2f bonus mult for every '%s' type removed this run.\nCurrently at x%0.2f points." % [type_to_string(_combo_type), _scaling, type_to_string(_combo_type), _points_to_mult]
