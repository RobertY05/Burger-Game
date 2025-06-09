extends Topping

var times_played = 0

func _init():
	topping_name = "Feta"
	topping_type = "Cheese"
	height = 1
	rarity = tiers.UNCOMMON
	cost = 8

func calculate(topping_list : Array[Topping], game_controller : GameController):
	game_controller.add_points(115 - times_played * 15)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	times_played += 1

func get_description():
	return "+115 points when graded. \n Lose 15 points each time this card was played previously when graded. \n You will lose " + str((times_played + 1) * 15) + " points."
