extends Topping

const _cards_to_draw = 3

func _init():
	topping_name = "Olive"
	topping_type = types.VEGETABLE
	height = 3
	rarity = tiers.COMMON
	cost = 7

func calculate(topping_list : Array[Topping], game_controller : GameController):
	game_controller.draw_card(_cards_to_draw)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "Draw %d cards when graded." % _cards_to_draw
