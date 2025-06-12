extends Topping

const _scaling = 10
const _combo_type = types.VEGETABLE

var _points_to_add = 0

func _init():
	topping_name = "Tiny Horse"
	topping_type = types.PROTEIN
	height = 80
	rarity = tiers.RARE
	cost = 45

func calculate(topping_list : Array[Topping], game_controller : GameController):
	var my_idx = topping_list.find(self)
	var needs_change = false
	for i in range(my_idx - 1, -1, -1):
		if topping_list[i].topping_type != _combo_type:
			break
		game_controller.burger.destroy_topping(i)
		_points_to_add += _scaling
		needs_change = true
	game_controller.add_points(_points_to_add)
	
	if needs_change:
		stats_changed.emit()

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "Removes all '%s' type toppings immediately below the horse when graded.\n+%d points for every '%s' type removed this run.\nCurrently at +%d points." % [type_to_string(_combo_type), _scaling, type_to_string(_combo_type), _points_to_add]
