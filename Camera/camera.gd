extends Camera2D

var desired_position = Vector2.ZERO
var _lerp_speed = 0.4

func _physics_process(delta):
	global_position = lerp(global_position, desired_position, _lerp_speed)
