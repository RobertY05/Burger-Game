extends Node2D

@export var _card_back_protein : CompressedTexture2D
@export var _card_back_cheese : CompressedTexture2D
@export var _card_back_vegetable : CompressedTexture2D
@export var _card_back_sauce : CompressedTexture2D
@export var _card_back_other : CompressedTexture2D

# stored topping
var _topping : Topping

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

func get_topping():
	return _topping

# call this after setting up
func setup(topping):
	_topping = topping
	$CardImage.texture = topping.get_image()
	
	if _topping.topping_type == _topping.types.PROTEIN:
		$CardBack.texture = _card_back_protein
	elif _topping.topping_type == _topping.types.CHEESE:
		$CardBack.texture = _card_back_cheese
	elif _topping.topping_type == _topping.types.VEGETABLE:
		$CardBack.texture = _card_back_vegetable
	elif _topping.topping_type == _topping.types.SAUCE:
		$CardBack.texture = _card_back_sauce
	elif _topping.topping_type == _topping.types.OTHER:
		$CardBack.texture = _card_back_other
	
	update_description()

func update_description():
	$CardName.text = _topping.topping_name
	$CardType.text = _topping.type_to_string(_topping.topping_type)
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
