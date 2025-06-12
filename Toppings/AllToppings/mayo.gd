extends Topping

const _combo_type = types.PROTEIN
const _regrade_times = 4

var done = false

func _init():
	topping_name = "Mayo"
	topping_type = types.SAUCE
	height = 1
	rarity = tiers.COMMON
	cost = 15

func calculate(topping_list : Array[Topping], game_controller : GameController):
	var my_idx = topping_list.find(self)
	
	if not done:
		if my_idx > 0 and topping_list[my_idx - 1].topping_type == _combo_type:
			for i in range(_regrade_times):
				topping_list[my_idx - 1].calculate(topping_list, game_controller)
				topping_list[my_idx - 1].flash()
	done = true
	
func on_play(topping_list : Array[Topping], game_controller : GameController):
	done = false

func get_description():
	return "When graded, grade the topping immediately below it %d times if it is a '%s' type.\nCannot be graded more than once." % [_regrade_times, type_to_string(_combo_type)]
