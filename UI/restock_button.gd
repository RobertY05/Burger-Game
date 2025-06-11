extends Sprite2D

@onready var _size = Vector2(texture.get_width(), texture.get_height())
@onready var _label = $Label

var _desired_scale = Vector2(1, 1)
var _big = Vector2(1.1, 1.1)
var _little = Vector2(0.8, 0.8)
var _lerp_speed = 0.4

signal on_clicked

func change_text(text):
	_label.text = text

func _process(delta):
	var box = Rect2(global_position - _size / 2, _size)
	_desired_scale = Vector2(1, 1)
	if box.has_point(get_global_mouse_position()):
		_desired_scale = _big
		if Input.is_action_just_pressed("left_click"):
			scale = _little
			on_clicked.emit()

func _physics_process(delta):
	scale = lerp(scale, _desired_scale, _lerp_speed)
