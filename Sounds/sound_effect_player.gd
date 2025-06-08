extends AudioStreamPlayer

@export var _min_pitch = 1.0
@export var _max_pitch = 1.0

func play_sound():
	pitch_scale = randf_range(_min_pitch, _max_pitch)
	play()
