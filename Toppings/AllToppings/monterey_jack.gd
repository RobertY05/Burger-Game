extends Topping

const _scaling = 5

static var _times_played = 0
static var _all_jacks = []

func _init():
	topping_name = "Monterey Jack"
	topping_type = types.CHEESE
	height = 5
	rarity = tiers.COMMON
	cost = 30
	_all_jacks.push_back(self)

func calculate(topping_list : Array[Topping], game_controller : GameController):
	game_controller.add_points(_times_played * _scaling)

func on_play(topping_list : Array[Topping], game_controller : GameController):
	_times_played += 1
	for jack in _all_jacks:
		jack.stats_changed.emit()

func get_description():
	return "+%d points for every 'Monterey Jack' played this run.\n'%s' will earn at least %d points." % [_scaling, topping_name, _times_played * 5] 

func reset():
	_times_played = 0

func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		_all_jacks.erase(self)
