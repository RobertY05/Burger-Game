extends Topping

const _flat_points = 15
const _cards_to_draw = 1

func _init():
	topping_name = "Tomato"
	topping_type = types.VEGETABLE
	height = 5
	rarity = tiers.COMMON
	cost = 7

func calculate(topping_list : Array[Topping], game_controller : GameController):
	pass

func on_play(topping_list : Array[Topping], game_controller : GameController):
	game_controller.add_points(_flat_points)
	game_controller.draw_card(_cards_to_draw)

func get_description():
	return "+%d points when played. \nDraw %d card." % [_flat_points, _cards_to_draw]
