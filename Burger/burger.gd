class_name Burger
extends Node2D

var _is_done = false

var _desired_position = null

var _top = 0
var _max_offset = 5
var toppings : Array[Topping] = []

var peek_offset = 40

var _game_controller_ref = null

var _top_margin = 50
var _camera_ref = null
var _lerp_speed = 0.4

@onready var top_bun = $TopBun
var top_bun_desired_y = 0

signal calculation_done()
@onready var _calculation_timer = $CalculationTimer
var _calculation_delay_time = 0.5
var _min_calculation_delay_time = 0.01
var _calculation_lerp_speed = 0.1
var calculation_idx = 0

func setup(game_controller, camera):
	_desired_position = global_position
	_game_controller_ref = game_controller
	_camera_ref = camera

func add_topping(topping : Node2D):
	add_child(topping)
	topping.desired_position = Vector2(to_global(Vector2.ZERO).x + randi_range(-_max_offset, _max_offset), _top)
	topping.global_position = Vector2(to_global(Vector2.ZERO).x, _camera_ref.global_position.y - get_viewport_rect().size.y)
	topping.process_mode = Node.PROCESS_MODE_INHERIT
	topping.show()
	toppings.push_back(topping)
	_top -= topping.height
	
	if _top < _camera_ref.desired_position.y - get_viewport_rect().size.y / 2 + _top_margin:
		_camera_ref.desired_position.y -= topping.height

func calculate():
	
	top_bun.global_position = Vector2(to_global(Vector2.ZERO).x, _camera_ref.global_position.y - get_viewport_rect().size.y)
	top_bun_desired_y = _top
	
	remove_child(top_bun)
	add_child(top_bun)
	
	top_bun.show()
	
	_camera_ref.desired_position.y = 0
	_calculation_timer.start(_calculation_delay_time)
	
	for i in range(1, toppings.size()):
		toppings[i].desired_position.y -= peek_offset
	top_bun_desired_y -= peek_offset

func _on_calculation_timer_timeout() -> void:
	if calculation_idx < toppings.size():
		$GradeSound.play()
		$GradeSound.pitch_scale = min($GradeSound.pitch_scale * 1.01, 2.5)
		toppings[calculation_idx].bounce()
		toppings[calculation_idx].calculate(toppings, _game_controller_ref)
		if calculation_idx != 0:
			toppings[calculation_idx].desired_position.y += peek_offset
		calculation_idx += 1
	if calculation_idx < toppings.size():
		_calculation_delay_time = lerp(float(_calculation_delay_time), float(_min_calculation_delay_time), _calculation_lerp_speed)
		_camera_ref.desired_position.y = toppings[calculation_idx].global_position.y
		_calculation_timer.start(_calculation_delay_time)
	else:
		$FinishedTimer.start()

func _on_pause_finished() -> void:
	_camera_ref.desired_position.y = 0
	_is_done = true
	top_bun_desired_y += peek_offset

func _physics_process(delta):
	top_bun.global_position.y = lerp(top_bun.global_position.y, float(top_bun_desired_y), _lerp_speed)
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
