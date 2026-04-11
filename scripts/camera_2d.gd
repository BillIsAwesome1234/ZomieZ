extends Camera2D

@export var max_offset := 100.0
@export var smoothing := 5.0

func _process(delta):
	var screen_center = get_viewport_rect().size * 0.5
	var mouse_position = get_viewport().get_mouse_position()
	var offset = mouse_position - screen_center
	
	# Clamp how far the camera can move
	offset = offset.limit_length(max_offset)
	
	# Smooth movement
	offset = lerp(self.offset, offset, smoothing * delta)
	
	self.offset = offset
