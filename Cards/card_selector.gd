extends Node2D

signal card_played(topping)

@export var _card_scene : PackedScene

var enabled = false

# pixels from bottom of screen where card should be shown
var _disabled_y = 100
var _rest_y = 150
var _hover_y = 200

# pixels from bottom of screen where to take input
var _mouse_y = 350

# list of cards in hand
var _hand = []

var _desired_card_width = 250
var _actual_width = 250
var _min_width = 150

# margin for max length
var _screen_margin = 150

var _game_controller_ref = null

func setup(game_controller):
	_game_controller_ref = game_controller

func make_card(topping):
	var new_card = _card_scene.instantiate()
	new_card.setup(topping)
	new_card.global_position = Vector2(get_viewport_rect().size.x * 2, get_viewport_rect().size.y - _rest_y)
	_hand.push_back(new_card)
	add_child(new_card)

func empty(do_animation):
	for i in _hand:
		if do_animation:
			i.play()
		else:
			i.drop()
	_hand = []

func _process(delta):
	var length = min(get_viewport_rect().size.x - _screen_margin * 2, _desired_card_width * _hand.size())
	
	if _hand.size() == 0:
		_actual_width = _desired_card_width
	else:
		_actual_width = length / _hand.size()
	
	var left = (get_viewport_rect().size.x - length) / 2 + _actual_width / 2
	var selected_idx = _hand.size()
	
	for i in range(_hand.size()):
		_hand[i].desired_position.x = left + i * _actual_width
		if enabled:
			_hand[i].desired_position.y = get_viewport_rect().size.y - _rest_y
			if get_viewport_rect().size.y - get_viewport().get_mouse_position().y < _mouse_y:
				var mouse_x = get_viewport().get_mouse_position().x
				if mouse_x > left + i * _actual_width - _actual_width / 2 and mouse_x < left + (i + 1) * _actual_width - _actual_width / 2:
					selected_idx = i
					_hand[i].desired_position.y = get_viewport_rect().size.y - _hover_y
					if Input.is_action_just_pressed("left_click"):
						if _game_controller_ref.play_mode != _game_controller_ref.modes.PLAY:
							card_played.emit(_hand[i].drop())
						else:
							$SoundEffectPlayer.play_sound()
							card_played.emit(_hand[i].play())
						_hand.pop_at(i)
						break
		else:
			_hand[i].desired_position.y = get_viewport_rect().size.y - _disabled_y
	
	if selected_idx != _hand.size() and _actual_width < _min_width:
		var new_left = left + _min_width
		for i in range(selected_idx + 1, _hand.size()):
			_hand[i].desired_position.x = new_left + i * _actual_width
	
	
