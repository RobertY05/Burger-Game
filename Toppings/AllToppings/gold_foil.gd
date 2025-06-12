extends Topping

const _money_awarded = 1

func _init():
	topping_name = "Gold Foil"
	topping_type = types.OTHER
	height = 3
	rarity = tiers.UNCOMMON
	cost = 25

func calculate(topping_list : Array[Topping], game_controller : GameController):
	var my_idx = topping_list.find(self)
	game_controller.set_money(game_controller.get_money() + my_idx * _money_awarded)
	for i in range(my_idx):
		topping_list[i].flash()

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "+%d money for every ingredient beneath it when graded." % _money_awarded
