extends Topping

const _combo = "Pickle"
const _combo_draw = 1

func _init():
	topping_name = "Pickle"
	topping_type = types.VEGETABLE
	height = 5
	rarity = tiers.COMMON
	cost = 3

func calculate(topping_list : Array[Topping], game_controller : GameController):
	pass

func on_play(topping_list : Array[Topping], game_controller : GameController):
	game_controller.draw_card()
	for i in range(topping_list.size()):
		if topping_list[i].topping_name == _combo:
			game_controller.draw_card(_combo_draw)
			topping_list[i].flash()

func get_description():
	return "Draw %d card for every '%s' played this burger." % [_combo_draw, _combo]
