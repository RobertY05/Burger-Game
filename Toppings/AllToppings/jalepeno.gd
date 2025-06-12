extends Topping

const _flat_points = -5
const _cards_to_draw = 5

func _init():
	topping_name = "Jalepeno"
	topping_type = types.VEGETABLE
	height = 1
	rarity = tiers.UNCOMMON
	cost = 7

func calculate(topping_list : Array[Topping], game_controller : GameController):
	game_controller.add_points(_flat_points)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	game_controller.draw_card(_cards_to_draw)

func get_description():
	return "Draw %d cards when played.\n%d points when graded." % [_cards_to_draw, _flat_points]
