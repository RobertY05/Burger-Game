extends Topping

const _convert_type = types.CHEESE

func _init():
	topping_name = "Cheese Sauce"
	topping_type = types.SAUCE
	height = 4
	rarity = tiers.RARE
	cost = 20

func calculate(topping_list : Array[Topping], game_controller : GameController):
	var my_idx = topping_list.find(self)
	if my_idx - 1 > 0 and topping_list[my_idx - 1].topping_type != _convert_type:
		topping_list[my_idx - 1].topping_type = _convert_type
		topping_list[my_idx - 1].stats_changed.emit()
		topping_list[my_idx - 1].flash()

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "When graded, permanently turn the topping immediately beneath it into '%s' type" % type_to_string(_convert_type) 
