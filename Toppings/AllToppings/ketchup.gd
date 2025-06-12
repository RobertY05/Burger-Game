extends Topping

const _neg_combo_type = types.SAUCE

func _init():
	topping_name = "Ketchup"
	topping_type = types.SAUCE
	height = 1
	rarity = tiers.UNCOMMON
	cost = 12

func calculate(topping_list : Array[Topping], game_controller : GameController):
	var my_idx = topping_list.find(self)
	if my_idx - 1 > -1 and topping_list[my_idx - 1].topping_type != _neg_combo_type:
		topping_list[my_idx-1].flash()
		topping_list[my_idx-1].calculate(topping_list, game_controller)
	if my_idx + 1 < topping_list.size() and topping_list[my_idx + 1].topping_type != _neg_combo_type:
		topping_list[my_idx+1].flash()
		topping_list[my_idx+1].calculate(topping_list, game_controller)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "When graded, also grade the topping above and below it.\nDoes not work on '%s' type" % type_to_string(_neg_combo_type)
