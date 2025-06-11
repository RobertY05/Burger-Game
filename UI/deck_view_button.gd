extends Sprite2D

@onready var _size = Vector2(texture.get_width(), texture.get_height())

var _desired_scale = Vector2(1, 1)
var _big = Vector2(1.1, 1.1)
var _little = Vector2(0.8, 0.8)
var _lerp_speed = 0.4

var _selected_modulate = Color.BEIGE
var _toggled = false

signal on_clicked

func toggle(value = not _toggled):
	_toggled = value
	if _toggled:
		modulate = _selected_modulate
	else:
		modulate = Color.WHITE

func _process(delta):
	var box = Rect2(global_position - _size / 2, _size)
	_desired_scale = Vector2(1, 1)
	if box.has_point(get_global_mouse_position()):
		_desired_scale = _big
		if Input.is_action_just_pressed("left_click"):
			scale = _little
			_toggled = not _toggled
			toggle()
			on_clicked.emit()

func _physics_process(delta):
	scale = lerp(scale, _desired_scale, _lerp_speed)
