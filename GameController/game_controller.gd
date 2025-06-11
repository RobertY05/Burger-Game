class_name GameController
extends Node2D

@export var all_toppings : Array[PackedScene]

@onready var _camera = $Camera

@onready var _card_selector = $Camera/CanvasLayer/CardSelector
@onready var _shop = $Camera/CanvasLayer/Shop

@onready var _hud = $Camera/Hud
@onready var burger_number = $Camera/Hud/BurgerNumber
@onready var _target_label = $Camera/Hud/TargetLabel
@onready var _rate_label = $Camera/Hud/RateLabel
@onready var _points_label = $Camera/Hud/PointsLabel
@onready var _money_label = $Camera/Hud/MoneyLabel
@onready var _cards_label = $Camera/Hud/CardsLabel
@onready var _mode_label = $Camera/Hud/ModeLabel
@onready var _deck_view_button = $Camera/Hud/DeckViewButton

@onready var _card_sound = $CardSound

var _money_percent = 0.2

# how far done button shows up from the right
var _done_button_margin_x = 200

# how far from center done button goes down
var _done_button_offset_y = 100

var _comic_position = Vector2(0, 1200)

var _show_tutorial = true

var _need_button = true

# -----run variables------

# "level / difficulty"
var _heat = 0

var _money = 0

var deck = []

var _hand_size = 5

# -----run variables------

# -----play variables------

# points scored this "play"
var _points = 0

# list of toppings that represent the draw pile
var draw_pile = []

# what to do with the next card, freely mutated
# "play" 		-> add next topping
# "shuffle" 		-> puts next "play_mode_count" cards into random spot in draw pile
# "bottom"		-> puts next "play_mode_count" cards into bottom
enum modes {PLAY, SHUFFLE, BOTTOM}
var play_mode = modes.PLAY
var play_mode_count = 0

# will store a list of 3 integers
# number of stars awarded will be points / _target_scores[i]
var _target_scores = []
var _cur_target = 0

@export var _burger_scene : PackedScene
# stores a reference to a burger
var burger : Burger

@export var _done_button_scene : PackedScene

# -----play variables------

func get_points():
	return _points

func set_points(new_points : int):
	if _points != new_points:
		_points = new_points
		_points_label.change_text("POINTS: " + str(new_points))

func add_points(new_points : int):
	print("Add ", str(new_points))
	set_points(get_points() + new_points)

func multiply_points(new_points : float):
	print("Mult ", str(new_points))
	set_points(int(get_points() * new_points))

func get_money():
	return _money

func set_money(new_money : int):
	if _money != new_money:
		_money = new_money
		_money_label.change_text("MONEY: " + str(new_money))

func set_mode(mode, times = 1):
	play_mode = mode
	play_mode_count = times
	_update_mode_label()

# sets variables to default, starts the game
func reset_game():
	set_points(0)
	
	_hud.show()
	
	_camera.global_position = Vector2.ZERO
	_camera.desired_position = Vector2.ZERO
	
	deck = []
	# temp reset...
	for topping in all_toppings:
		var probe = topping.instantiate()
		
		if probe.topping_name == "Beef Patty":
			for i in range(2):
				deck.push_back(topping.instantiate())
		if probe.topping_name == "Cheddar":
			for i in range(3):
				deck.push_back(topping.instantiate())
		if probe.topping_name == "Lettuce":
			for i in range(2):
				deck.push_back(topping.instantiate())
		if probe.topping_name == "Ketchup":
			for i in range(1):
				deck.push_back(topping.instantiate())
		
		probe.queue_free()
	
	set_money(0)
	_heat = 0
	_hand_size = 5
	
	_target_scores = [10, 15, 20]
	
	start_day()

# resets your draw pile, calculates the difficulties, etc.
func start_day():
	play_mode_count = 0
	
	_shop.dismiss()
	
	_card_selector.viewing = false
	_deck_view_button.toggle(false)
	
	draw_pile = deck.duplicate()
	draw_pile.shuffle()
	
	for i in range(_target_scores.size()):
		_target_scores[i] += _target_scores[i] * 0.05 + _heat * 4
		_target_scores[i] = int(_target_scores[i])
	
	_heat += 1
	
	_cur_target = 0
	_update_burger_number()
	_update_card_label()
	_update_target_label()
	_new_burger()

func _new_burger():
	burger = _burger_scene.instantiate()
	burger.setup(self, _camera)
	burger.calculation_done.connect(_on_calculation_done)
	burger.global_position.x = -get_viewport_rect().size.x
	add_child(burger)

	_update_target_label()

	for i in range(_hand_size):
		draw_card()
	
	_need_button = true

func _grade_burger():
	burger.calculate()
	set_mode(modes.PLAY)
	_card_selector.enabled = false

func _close_shop():
	_shop.dismiss()
	start_day()

func _create_done_button(fun, word = "Done"):
	var done_button = _done_button_scene.instantiate()
	done_button.clicked.connect(fun)
	done_button.global_position = Vector2(2 * get_viewport_rect().size.x, get_viewport_rect().size.y / 2 + _done_button_offset_y)
	done_button.desired_position = Vector2(get_viewport_rect().size.x - _done_button_margin_x, get_viewport_rect().size.y / 2 + _done_button_offset_y)
	done_button.set_word(word)
	$Camera/CanvasLayer.add_child(done_button)

# permanently acquire a card
func get_card(topping):
	deck.push_back(topping)
	draw_pile.push_back(topping)
	_update_card_label()
	if _card_selector.viewing:
		_card_selector.add_card(topping)

# draws a topping from draw_pile and generates a card, does nothing if deck is empty
func draw_card(x = 1):
	var play_sound = false
	for i in range(x):
		if draw_pile.size() > 0:
			_card_selector.add_card(draw_pile.pop_back())
			_update_card_label()
			play_sound = true
	if play_sound:
		_card_sound.play()
	

func _on_card_played(topping):
	if play_mode == modes.SHUFFLE:
		draw_pile.insert(randi_range(0, draw_pile.size()), topping)
		play_mode_count -= 1
		if play_mode_count == 0:
			set_mode(modes.PLAY)
		_update_card_label()
		return
	elif play_mode == modes.BOTTOM:
		draw_pile.insert(0, topping)
		play_mode_count -= 1
		if play_mode_count == 0:
			set_mode(modes.PLAY)
		_update_card_label()
		return
	
	# actually play the card
	topping.on_play(burger.toppings, self)
	burger.add_topping(topping)

func _on_calculation_done() -> void:
	if _target_scores[_cur_target] > _points:
		_card_selector.empty(true)
		_hud.hide()
		$IntroComic.hide()
		$LoseComic.show()
		$LoseSound.play()
		_card_selector.enabled = false
		_card_selector.viewing = false
		_create_done_button(reset_game, "Ok")
		
		_camera.desired_position = _comic_position
		_camera.global_position = _comic_position
		return
	
	$WinSound.play()
	var rate = int(_target_scores[_cur_target] * _money_percent)
	set_money(get_money() + (_points - _target_scores[_cur_target]) / rate)
	set_points(0)
	
	_cur_target += 1
	if _cur_target < _target_scores.size():
		_new_burger()
		_update_burger_number()
	else:
		_card_selector.empty(false)
		_card_selector.viewing = false
		_deck_view_button.toggle(false)
		_shop.generate()
		draw_pile = deck.duplicate()
		_update_card_label()
		
		_create_done_button(_close_shop)

func _update_burger_number():
	burger_number.text = "BURGER " + str(_cur_target + 1) + "/3"

func _update_target_label():
	_target_label.text = "MIN POINTS: " + str(_target_scores[_cur_target])
	_rate_label.text = "1$ / " + str(int(_target_scores[_cur_target] * _money_percent)) + " POINTS EXTRA"

func _update_card_label():
	_cards_label.change_text("CARDS LEFT: " + str(draw_pile.size()))

func _update_mode_label():
	if play_mode == modes.PLAY:
		_mode_label.hide()
	else:
		_mode_label.show()
	
	if play_mode == modes.SHUFFLE:
		_mode_label.text = "SHUFFLE NEXT " + str(play_mode_count) + " CARDS"
	elif play_mode == modes.BOTTOM:
		_mode_label.text = "PLACE NEXT " + str(play_mode_count) + " CARDS AT THE BOTTOM OF YOUR DRAW PILE"

func _ready():
	var cheese_count = 0
	var vegetable_count = 0
	var protein_count = 0
	var other_count = 0
	for i in all_toppings:
		var probe = i.instantiate()
		probe.reset()
		if probe.topping_type == "Cheese":
			cheese_count += 1
		elif probe.topping_type == "Vegetable":
			vegetable_count += 1
		elif probe.topping_type == "Protein":
			protein_count += 1
		else:
			other_count += 1
		
		probe.queue_free()
	print("Cheese: ", cheese_count)
	print("Vegetable: ", vegetable_count)
	print("Protein: ", protein_count)
	print("Other: ", other_count)
	_hud.hide()
	_camera.global_position = _comic_position
	_camera.desired_position = _comic_position
	_card_selector.setup(self)
	_shop.setup(self)
	
	_create_done_button(reset_game, "Ok")
	
func _process(delta):
	if burger != null and burger.global_position.x < 0 and burger.global_position.x > -3:
		burger.global_position.x = 0
		_card_selector.enabled = true
		if _need_button:
			_need_button = false
			_create_done_button(_grade_burger)


func _view_deck() -> void:
	_deck_view_button.toggle()
	_card_selector.toggle_view()
