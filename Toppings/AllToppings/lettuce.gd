extends Topping

const _cards_to_draw = 2

func _init():
	topping_name = "Lettuce"
	topping_type = types.VEGETABLE
	height = 3
	rarity = tiers.COMMON
	cost = 5

func calculate(topping_list : Array[Topping], game_controller : GameController):
	pass

func on_play(topping_list : Array[Topping], game_controller : GameController):
	game_controller.draw_card(_cards_to_draw)

func get_description():
	return "Draw %d cards when played." % _cards_to_draw
