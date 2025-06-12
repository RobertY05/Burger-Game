extends Topping

const _flat_points = 50
const _combo_type = types.PROTEIN
const _flat_mult = 2

@export var _closed_trap_scene : PackedScene
var _closed_trap = null

func _init():
	topping_name = "Bear Trap"
	topping_type = types.OTHER
	height = 10
	rarity = tiers.UNCOMMON
	cost = 25

func calculate(topping_list : Array[Topping], game_controller : GameController):
	game_controller.add_points(_flat_points)
	
	var my_idx = topping_list.find(self)
	if my_idx + 1 < topping_list.size() and topping_list[my_idx + 1].topping_type == _combo_type:
		if _closed_trap == null:
			_closed_trap = _closed_trap_scene.instantiate()
		game_controller.burger.insert_topping(my_idx, _closed_trap)
		game_controller.burger.destroy_topping(my_idx + 1)
		game_controller.burger.destroy_topping(my_idx + 1)
		

func on_play(topping_list : Array[Topping], game_controller : GameController):
	pass

func get_description():
	return "When graded, +%d points and remove the topping immediately above it if it is a '%s' type.\nx%0.2f points if graded again after removing a topping" % [_flat_points, type_to_string(_combo_type), _flat_mult]

func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		if _closed_trap != null:
			_closed_trap.queue_free()
