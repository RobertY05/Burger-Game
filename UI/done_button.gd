extends Node2D

signal clicked

@onready var _button_size = Vector2($Done.texture.get_width(), $Done.texture.get_height())

var desired_position = Vector2(0, 0)

var _desired_scale = Vector2(1, 1)
var _big = Vector2(1.1, 1.1)
var _lerp_speed = 0.4

var _dying = false

var _velocity = Vector2.ZERO
var _gravity = Vector2(0, 3)

var _spin = 0
var _min_spin = 20
var _max_spin = 40

var _min_jump_y = 30
var _max_jump_y = 50
var _max_jump_x = 30

func set_word(word):
	for i in get_children():
		if i.name == word:
			i.show()
		else:
			i.hide()

func _physics_process(delta):
	var box = Rect2(global_position - _button_size / 2, _button_size)
	if !_dying and box.has_point(get_global_mouse_position()):
		_desired_scale = _big
		if Input.is_action_just_pressed("left_click"):
			_dying = true
			clicked.emit()
			_spin = randi_range(_min_spin, _max_spin)
			if randi_range(0, 1) == 1:
				_spin *= -1
			_velocity = Vector2(randi_range(-_max_jump_x, _max_jump_x), -randi_range(_min_jump_y, _max_jump_y))
	else:
		_desired_scale = Vector2(1, 1)
	
	scale = lerp(scale, _desired_scale, _lerp_speed)
	if _dying:
		global_rotation_degrees += _spin
		global_position += _velocity
		_velocity += _gravity
		
		if position.y > get_viewport_rect().size.y * 2:
			queue_free()
	else:
		global_position = lerp(global_position, desired_position, _lerp_speed)
