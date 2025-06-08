extends Node2D

@export var _seller_scene : PackedScene

var desired_position = Vector2.ZERO
var _lerp_speed = 0.4

var _kill_children = false

var _game_controller_ref = null

var _seller_width = 300
var _options = 4

func setup(game_controller):
	_game_controller_ref = game_controller

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
			break
		var new_seller = _seller_scene.instantiate()
		add_child(new_seller)
		new_seller.setup(_game_controller_ref, topping)
		new_seller.position = Vector2(left + _seller_width * i + _seller_width / 2,  middle.y)
		

func dismiss():
	_kill_children = true
	desired_position = Vector2(get_viewport_rect().size.x, 0)

func _physics_process(delta):
	global_position = lerp(global_position, desired_position, _lerp_speed)
	if _kill_children and global_position.x > get_viewport_rect().size.x * 0.9:
		_kill_children = false
		for child in get_children():
			child.queue_free()
