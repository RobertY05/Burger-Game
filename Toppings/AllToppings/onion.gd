extends Topping

const _cards_to_draw = 3
const _cards_to_shuffle = 2

func _init():
	topping_name = "Onion"
	topping_type = types.VEGETABLE
	height = 5
	rarity = tiers.COMMON
	cost = 6

func calculate(topping_list : Array[Topping], game_controller : GameController):
	pass

func on_play(topping_list : Array[Topping], game_controller : GameController):
	game_controller.set_mode(game_controller.modes.BOTTOM, _cards_to_shuffle)
	game_controller.draw_card(_cards_to_draw)

func get_description():
	return "Draw %d cards.\nThe next %d cards you play will be sent to the bottom of your draw pile." % [_cards_to_draw, _cards_to_shuffle]
