extends Node2D

@export var _seller_scene : PackedScene

@onready var _restock_button = $RestockButton
@onready var _sellers = $Sellers

var desired_position = Vector2.ZERO
var _lerp_speed = 0.4

var _kill_children = false

var _game_controller_ref = null

var _seller_width = 250
var _seller_height = 500
var _options = 4

var _restock_cost = 5
var _base_restock_cost = 5
var _restock_price_increase = 2

func setup(game_controller):
	_game_controller_ref = game_controller
	_restock_button.change_text(str(_restock_cost) + " MONIES")

func generate():
	desired_position = Vector2.ZERO
	global_position = Vector2(get_viewport_rect().size.x * 2.5, 0)
	
	var middle = get_viewport_rect().size / 2
	var left = middle.x - (_options * _seller_width) / 2
	
	for i in range(_options):
		var topping = null
		while true:
			var all_toppings = _game_controller_ref.all_toppings
			topping = all_toppings[randi_range(0, all_toppings.size() - 1)].instantiate()
			if topping.rarity == topping.tiers.UNCOMMON and randi_range(1, 5) == 1:
				continue
			if topping.rarity == topping.tiers.RARE and randi_range(1,3) == 1:
				continue
			
			if topping.cost > _game_controller_ref.get_money() and randi_range(1, 4) == 1:
				continue
				
			break
		var new_seller = _seller_scene.instantiate()
		_sellers.add_child(new_seller)
		new_seller.setup(_game_controller_ref, topping)
		new_seller.position = Vector2(left + _seller_width * i + _seller_width / 2,  middle.y)
		_restock_button.position = Vector2(middle.x, middle.y - _seller_height / 2 - 50)
		_restock_button.show()

func dismiss():
	_kill_children = true
	desired_position = Vector2(get_viewport_rect().size.x, 0)
	_restock_cost = _base_restock_cost
	_restock_button.change_text(str(_restock_cost) + " MONIES")

func _physics_process(delta):
	global_position = lerp(global_position, desired_position, _lerp_speed)
	if _kill_children and global_position.x > get_viewport_rect().size.x * 0.9:
		_kill_children = false
		for child in _sellers.get_children():
			child.queue_free()

func _on_restock_button_on_clicked() -> void:
	if _game_controller_ref.get_money() > _restock_cost:
		_game_controller_ref.set_money(_game_controller_ref.get_money() - _restock_cost)
		_restock_cost += _restock_price_increase
		_restock_button.change_text(str(_restock_cost) + " MONIES")
		for i in _sellers.get_children():
			i.kill()
		generate()
		$BuySound.play_sound()
