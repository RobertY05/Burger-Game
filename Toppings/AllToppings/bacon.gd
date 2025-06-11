extends Topping

const _flat_points = 50
const _bonus_points = 25
const _combo = "Egg"

func _init():
	topping_name = "Bacon"
	topping_type = types.PROTEIN
	height = 5
	rarity = tiers.COMMON
	cost = 18

func calculate(topping_list : Array[Topping], game_controller : GameController):
	game_controller.add_points(_flat_points)
	var my_idx = topping_list.find(self)
	for i in range(my_idx + 1, topping_list.size()):
		if topping_list[i].topping_name == _combo:
			topping_list[i].flash()
			game_controller.add_points(_bonus_points)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "+%d points when graded. \nAdditional %d points for every %s placed above this topping." % [_flat_points, _bonus_points, _combo]
