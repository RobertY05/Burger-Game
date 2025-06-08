extends Topping

func _init():
	topping_name = "Gold Foil"
	topping_type = "Other"
	height = 3
	rarity = tiers.UNCOMMON
	cost = 50

func calculate(topping_list : Array[Topping], game_controller : GameController):
	var my_idx = topping_list.find(self)
	game_controller.set_money(game_controller.get_money() + my_idx)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "+1 money for every ingredient beneath it when graded."
