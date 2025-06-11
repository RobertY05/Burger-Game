class_name Burger
extends Node2D

var _is_done = false

var _desired_position = null

var _top = 0
var _max_offset = 5
var toppings : Array[Topping] = []

var _peek_offset = 40

var _game_controller_ref = null

var _top_margin = 50
var _camera_ref = null
var _lerp_speed = 0.4

@onready var _top_bun = $TopBun
var _top_bun_desired_y = 0

signal calculation_done()
@onready var _calculation_timer = $CalculationTimer
var _calculation_delay_time = 0.5
var _min_calculation_delay_time = 0.01
var _calculation_lerp_speed = 0.1
var _calculation_idx = -1

func setup(game_controller, camera) -> void:
	_desired_position = global_position
	_game_controller_ref = game_controller
	_camera_ref = camera

func add_topping(topping : Node2D) -> void:
	add_child(topping)
	topping.desired_position = Vector2(to_global(Vector2.ZERO).x + randi_range(-_max_offset, _max_offset), _top)
	topping.global_position = Vector2(to_global(Vector2.ZERO).x, _camera_ref.global_position.y - get_viewport_rect().size.y)
	topping.process_mode = Node.PROCESS_MODE_INHERIT
	topping.show()
	toppings.push_back(topping)
	_top -= topping.height
	
	if _top < _camera_ref.desired_position.y - get_viewport_rect().size.y / 2 + _top_margin:
		_camera_ref.desired_position.y -= topping.height

func destroy_topping(i : int) -> void:
	_calculation_idx = max(0, _calculation_idx - 1)
	if i < toppings.size() and i > -1:
		var destroyed = toppings.pop_at(i)
		for j in range(i, toppings.size()):
			toppings[j].desired_position.y += destroyed.height
		_top_bun_desired_y += destroyed.height
		_top += destroyed.height
		remove_child(destroyed)

func insert_topping(i : int, topping : Topping) -> void:
	var height = 0
	for j in range(i):
		height += toppings[j].height
		
	toppings.insert(i, topping)
	var new_pos = to_global(Vector2.ZERO) + Vector2(randi_range(-_max_offset, _max_offset), -height)
	topping.global_position = new_pos
	topping.desired_position = new_pos
	add_child(topping)
	
	for j in range(i + 1, toppings.size()):
		toppings[j].global_position.y -= topping.height
		toppings[j].desired_position.y -= topping.height
		remove_child(toppings[j])
		add_child(toppings[j])
	
	if _calculation_idx != -1 and _calculation_idx < i:
		topping.global_position.y -= _peek_offset
		topping.desired_position.y -= _peek_offset
	
	_top_bun_desired_y -= topping.height
	_top -= topping.height

	remove_child(_top_bun)
	add_child(_top_bun)

func change_idx(i) -> void:
	for j in range(_calculation_idx + 1, toppings.size()):
		if j != 0:
			toppings[j].desired_position.y += _peek_offset
	for j in range(i + 1, toppings.size()):
		toppings[j].desired_position.y -= _peek_offset
	_calculation_idx = i

func calculate() -> void:
	_calculation_idx = 0
	_top_bun.global_position = Vector2(to_global(Vector2.ZERO).x, _camera_ref.global_position.y - get_viewport_rect().size.y)
	_top_bun_desired_y = _top
	
	remove_child(_top_bun)
	add_child(_top_bun)
	
	_top_bun.show()
	
	_camera_ref.desired_position.y = 0
	_calculation_timer.start(_calculation_delay_time)
	
	for i in range(1, toppings.size()):
		toppings[i].desired_position.y -= _peek_offset
	_top_bun_desired_y -= _peek_offset

func _on_calculation_timer_timeout() -> void:
	if _calculation_idx < toppings.size():
		$GradeSound.play()
		$GradeSound.pitch_scale = min($GradeSound.pitch_scale * 1.01, 2.5)
		toppings[_calculation_idx].bounce()
		if _calculation_idx != 0:
			toppings[_calculation_idx].desired_position.y += _peek_offset
		toppings[_calculation_idx].calculate(toppings, _game_controller_ref)
		_calculation_idx += 1
	if _calculation_idx < toppings.size():
		_calculation_delay_time = lerp(float(_calculation_delay_time), float(_min_calculation_delay_time), _calculation_lerp_speed)
		_camera_ref.desired_position.y = toppings[_calculation_idx].global_position.y
		_calculation_timer.start(_calculation_delay_time)
	else:
		$FinishedTimer.start()

func _on_pause_finished() -> void:
	_camera_ref.desired_position.y = 0
	_is_done = true
	_top_bun_desired_y += _peek_offset

func _physics_process(delta):
	_top_bun.global_position.y = lerp(_top_bun.global_position.y, float(_top_bun_desired_y), _lerp_speed)
	global_position = lerp(global_position, _desired_position, _lerp_speed / 8)
	
	if global_position.x + 3 < _desired_position.x:
		global_position.x += 3
	
	if global_position.x > _camera_ref.global_position.x + get_viewport_rect().size.x:
		for i in toppings:
			remove_child(i)
		calculation_done.emit()
		queue_free()
	
	if _is_done and _camera_ref.global_position.y > -1:
		for i in toppings:
			i.process_mode = Node.PROCESS_MODE_DISABLED
		_desired_position.x = get_viewport_rect().size.x * 1.2
