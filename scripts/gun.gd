extends AnimatedSprite2D

@onready var player: CharacterBody2D = $".."

func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)

	if player.global_position.x > mouse_pos.x:
		scale.y = -1
	else:
		scale.y = 1
