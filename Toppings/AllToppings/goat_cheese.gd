extends Topping

const _chance = 3
const _flat_points = 500

func _init():
	topping_name = "Goat Cheese"
	topping_type = types.CHEESE
	height = 10
	rarity = tiers.RARE
	cost = 25

func calculate(topping_list : Array[Topping], game_controller : GameController):
	if randi_range(1, _chance) == 1:
		game_controller.add_points(_flat_points)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "1 in %d chance to give +%d points." % [_chance, _flat_points]
