extends Topping

const _cards_to_draw = 4
const _neg_combo = 1
const _combo = "Pickle"

func _init():
	topping_name = "Cucumber"
	topping_type = types.VEGETABLE
	height = 5
	rarity = tiers.COMMON
	cost = 3

func calculate(topping_list : Array[Topping], game_controller : GameController):
	pass

func on_play(topping_list : Array[Topping], game_controller : GameController):
	var count = 4
	for i in range(topping_list.size()):
		if topping_list[i].topping_name == _combo:
			count -= _neg_combo
			topping_list[i].flash()
	if count > 0:
		game_controller.draw_card(_cards_to_draw)

func get_description():
	return "Draw %d cards.\nFor every '%s' played this burger draw %d less card." % [_cards_to_draw, _combo, _neg_combo]
