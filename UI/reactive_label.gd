extends Label

var _lerp_speed = 0.4

func _physics_process(delta):
	scale = lerp(scale, Vector2(1, 1), _lerp_speed)

func bounce():
	scale = Vector2(1.5, 1.5)

func change_text(new_text):
	text = new_text
	bounce()
