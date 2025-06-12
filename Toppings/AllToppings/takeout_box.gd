extends Topping

const _flat_money = 5

func _init():
	topping_name = "Takeout Box"
	topping_type = types.OTHER
	height = 40
	rarity = tiers.RARE
	cost = 60

func calculate(topping_list : Array[Topping], game_controller : GameController):
	var my_idx = topping_list.find(self)
	if my_idx < topping_list.size():
		var dead_topping = topping_list[my_idx + 1]
		game_controller.burger.destroy_topping(my_idx + 1)
		game_controller.lose_card(dead_topping)
		game_controller.set_money(game_controller.get_money() + _flat_money)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "+%d money and permanently removes the topping immediately above from your deck when graded." % _flat_money
