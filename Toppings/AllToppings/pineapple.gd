extends Topping

const _mult = 6
const _cards_to_draw = 1

func _init():
	topping_name = "Pineapple"
	topping_type = types.VEGETABLE
	height = 10
	rarity = tiers.RARE
	cost = 12

func calculate(topping_list : Array[Topping], game_controller : GameController):
	pass

func on_play(topping_list : Array[Topping], game_controller : GameController):
	game_controller.multiply_points(_mult)
	game_controller.draw_card(_cards_to_draw)

func get_description():
	return "x%d points when played.\nDraw %d card." % [_mult, _cards_to_draw]
