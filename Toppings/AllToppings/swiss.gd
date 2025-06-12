extends Topping

const _combo = "Swiss Cheese"
const _bonus_points = 20

func _init():
	topping_name = "Swiss Cheese"
	topping_type = types.CHEESE
	height = 5
	rarity = tiers.COMMON
	cost = 8

func calculate(topping_list : Array[Topping], game_controller : GameController):
	var my_idx = topping_list.find(self)
	var count = 0
	var found = false
	for i in range(my_idx - 1, -1, -1):
		if topping_list[i].topping_name == _combo:
			topping_list[i].flash()
			found = true
			break
		count += _bonus_points
	if found:
		game_controller.add_points(count)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "+%d points for every topping played between two '%s'." % [_bonus_points, _combo]
