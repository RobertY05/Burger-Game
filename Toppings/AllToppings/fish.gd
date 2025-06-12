extends Topping

const _combo_type = types.OTHER
const _bonus_points = 75

func _init():
	topping_name = "Fish"
	topping_type = types.PROTEIN
	height = 10
	rarity = tiers.UNCOMMON
	cost = 15

func calculate(topping_list : Array[Topping], game_controller : GameController):
	for i in range(topping_list.size()):
		if topping_list[i].topping_type == _combo_type:
			game_controller.add_points(_bonus_points)
			topping_list[i].flash()

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "+%d points for every '%s' type card played." % [_bonus_points, type_to_string(_combo_type)]
