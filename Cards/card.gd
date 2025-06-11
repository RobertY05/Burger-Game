extends Node2D

# stored topping
var _topping

var _dying = false

var _velocity = Vector2.ZERO
var _gravity = Vector2(0, 3)

var _spin = 0
var _min_spin = 20
var _max_spin = 40

var _min_jump_y = 30
var _max_jump_y = 50
var _max_jump_x = 30

var desired_position = position
var _lerp_speed = 0.4

# call this after setting up
func setup(topping):
	_topping = topping
	$CardImage.texture = topping.get_image()
	$CardName.text = topping.topping_name
	$CardType.text = topping.topping_type
	$CardDescription.text = topping.get_description()

func update_description():
	$CardDescription.text = _topping.get_description()

# starts the animation and returns the stored topping
func play():
	_dying = true
	_spin = randi_range(_min_spin, _max_spin)
	if randi_range(0, 1) == 1:
		_spin *= -1
	_velocity = Vector2(randi_range(-_max_jump_x, _max_jump_x), -randi_range(_min_jump_y, _max_jump_y))
	
	return _topping

# just start falling
func drop():
	_dying = true
	return _topping

func _physics_process(delta):
	if _dying:
		global_rotation_degrees += _spin
		global_position += _velocity
		_velocity += _gravity
		
		if position.y > get_viewport_rect().size.y * 2:
			queue_free()
	else:
		position = position.lerp(desired_position, _lerp_speed)
