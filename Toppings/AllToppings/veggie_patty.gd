extends Topping

const _flat_points = 20
const _bonus_points = 80
const _combo_type = types.PROTEIN

func _init():
	topping_name = "Veggie Patty"
	topping_type = types.VEGETABLE
	height = 10
	rarity = tiers.UNCOMMON
	cost = 15

func calculate(topping_list : Array[Topping], game_controller : GameController):
	game_controller.add_points(_flat_points)
	var protein = false
	for i in range(topping_list.size()):
		if topping_list[i].topping_type == types.PROTEIN:
			topping_list[i].flash()
			protein = true
	
	if not protein:
		game_controller.add_points(_bonus_points)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "+%d points when graded.\nAdditional +%d points if burger has no '%s' cards when graded." % [_flat_points, _bonus_points, type_to_string(_combo_type)]
