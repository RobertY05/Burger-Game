extends Topping

func _init():
	topping_name = "Ketchup"
	topping_type = "Other"
	height = 1
	rarity = tiers.UNCOMMON
	cost = 12

func calculate(topping_list : Array[Topping], game_controller : GameController):
	var my_idx = topping_list.find(self)
	if my_idx - 1 > -1 and topping_list[my_idx - 1].topping_name != topping_name:
		topping_list[my_idx-1].flash()
		topping_list[my_idx-1].calculate(topping_list, game_controller)
	if my_idx + 1 < topping_list.size() and topping_list[my_idx + 1].topping_name != topping_name:
		topping_list[my_idx+1].flash()
		topping_list[my_idx+1].calculate(topping_list, game_controller)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "When graded, also re-grade the topping above and below it. \n Does not work on 'Ketchup'"
