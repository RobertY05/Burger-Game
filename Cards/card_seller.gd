extends Node2D

@onready var _card = $Card

@onready var _card_size = Vector2($Card/CardBack.texture.get_width(), $Card/CardBack.texture.get_height())

var _game_controller_ref = null

var _desired_scale = Vector2(1, 1)
var _big = Vector2(1.1, 1.1)
var _lerp_speed = 0.4

var _cost = 0
var _purchased = false

func setup(game_controller, topping):
	_game_controller_ref = game_controller
	_card.setup(topping)
	_cost = topping.cost
	$PriceLabel.text = str(topping.cost) + " MONIES"

func _process(delta):
	var box = Rect2(global_position - _card_size / 2, _card_size)
	if !_purchased and box.has_point(get_global_mouse_position()):
		_desired_scale = _big
		if Input.is_action_just_pressed("left_click") and _game_controller_ref.get_money() >= _cost:
			_game_controller_ref.get_card(_card.play())
			_game_controller_ref.set_money(_game_controller_ref.get_money() - _cost)
			_purchased = true
			$PriceLabel.hide()
			$BuySound.play_sound()
	else:
		_desired_scale = Vector2(1, 1)
	
	if _card != null:
		_card.scale = lerp(_card.scale, _desired_scale, _lerp_speed)
