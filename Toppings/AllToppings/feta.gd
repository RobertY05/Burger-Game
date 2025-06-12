extends Topping

const _flat_points = 115
const _points_to_lose = 15

var _times_played = 0

func _init():
	topping_name = "Feta"
	topping_type = types.CHEESE
	height = 1
	rarity = tiers.UNCOMMON
	cost = 8

func calculate(topping_list : Array[Topping], game_controller : GameController):
	game_controller.add_points(_flat_points - _times_played * _points_to_lose)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	_times_played += 1
	stats_changed.emit()

func get_description():
	return "+%d points when graded.\nLose %d points each time this card was played previously when graded. \nYou will lose %d points when graded." % [_flat_points, _points_to_lose, (_times_played + 1) * 15]
