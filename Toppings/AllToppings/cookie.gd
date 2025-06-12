extends Topping

const _flat_points = 5

var _clickable = false
var _width = 200
var _height = 100

var _desired_size = Vector2(1, 1)
var _big = Vector2(1.5, 1.5)
var _little = Vector2(0.8, 0.8)

var _game_controller_ref = null

func _init():
	topping_name = "Cookie"
	topping_type = types.OTHER
	height = 10
	rarity = tiers.RARE
	cost = 25

func calculate(topping_list : Array[Topping], game_controller : GameController):
	_clickable = true

func on_play(topping_list : Array[Topping], game_controller : GameController):
	_clickable = false
	_game_controller_ref = game_controller

func get_description():
	return "Once graded, you can click on this cookie to earn +%d points." % _flat_points

func _process(delta):
	var box = Rect2(global_position - Vector2(_width, 50) / 2, Vector2(_width, 50))
	_desired_size = Vector2(1, 1)
	if box.has_point(get_global_mouse_position()) and _clickable:
		_desired_size = _big
		if Input.is_action_just_pressed("left_click"):
			_game_controller_ref.add_points(_flat_points)
			scale = _little

func _physics_process(delta):
	scale = lerp(scale, _desired_size, _lerp_speed)
	super._physics_process(delta)
