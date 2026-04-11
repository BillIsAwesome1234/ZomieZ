extends Camera2D

@export var max_offset := 100.0
@export var smoothing := 5.0
@export var deadzone_radius := 50.0

func _process(delta):
	var screen_center = get_viewport_rect().size * 0.5
	var mouse_position = get_viewport().get_mouse_position()
	var raw_offset = mouse_position - screen_center
	
	var offset = Vector2.ZERO
	
	# Only move camera if outside deadzone
	if raw_offset.length() > deadzone_radius:
		# Remove the deadzone portion so movement starts smoothly
		var direction = raw_offset.normalized()
		var adjusted_length = raw_offset.length() - deadzone_radius
		offset = direction * adjusted_length
	
	# Clamp to max distance
	offset = offset.limit_length(max_offset)
	
	# Smooth movement
	offset = lerp(self.offset, offset, smoothing * delta)
	
	self.offset = offset
