extends Topping

const _flat_points = 125
const _cards_to_shuffle = 2

func _init():
	topping_name = "Onion Rings"
	topping_type = types.OTHER
	height = 5
	rarity = tiers.UNCOMMON
	cost = 15

func calculate(topping_list : Array[Topping], game_controller : GameController):
	game_controller.add_points(_flat_points)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	game_controller.set_mode(game_controller.modes.SHUFFLE, _cards_to_shuffle)

func get_description():
	return "+%d points when graded.\nThe next %d cards you play will be shuffled randomly into your draw pile." % [_flat_points, _cards_to_shuffle]
