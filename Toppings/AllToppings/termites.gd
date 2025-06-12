extends Topping

@export var _sand_topping : PackedScene

const _stop_chance = 10
const _bonus_mult = 0.05
const _sand_name = "Sand"

var _sand_list = []

func _init():
	topping_name = "Termites"
	topping_type = types.PROTEIN
	height = 1
	rarity = tiers.RARE
	cost = 75

func calculate(topping_list : Array[Topping], game_controller : GameController):
	var my_idx = topping_list.find(self)
	var new_sand = _sand_topping.instantiate()
	_sand_list.push_back(new_sand)
	if randi_range(1, _stop_chance) == 1:
		var count = 0
		
		for topping in topping_list:
			if topping.topping_name == new_sand.topping_name:
				count += 1
		
		game_controller.multiply_points(1 + count * _bonus_mult)
	else:
		game_controller.burger.insert_topping(my_idx, new_sand)
	

func on_play(topping_list : Array[Topping], game_controller : GameController):
	for sand in _sand_list:
		sand.queue_free()

func get_description():
	return "1 in %d chance to score x(1+%0.2fX), where X is number of '%s' in burger.\nAdd 1 sand to the burger until successful." % [_stop_chance, _bonus_mult, _sand_name]

func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		for sand in _sand_list:
			sand.queue_free()
