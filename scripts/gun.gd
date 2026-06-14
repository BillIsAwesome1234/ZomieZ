extends AnimatedSprite2D

@onready var shotline: Line2D = $Line2D
@onready var player: CharacterBody2D = $".."
@export var shotduration = 0.05
@onready var raycast: RayCast2D = $RayCast2D

func _process(delta: float) -> void:
#	rotates towards the mouse
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	
#	flips x axis
	if player.global_position.x > mouse_pos.x:
		scale.y = -1
	else:
		scale.y = 1
		
	if Input.is_action_just_pressed("shoot"):
		fire()
		
func fire():
	raycast.force_raycast_update()
	var startpos = raycast.global_position
	var endpos: Vector2
	
	if raycast.is_colliding():
		endpos = raycast.get_collision_point()
	else:
		endpos = raycast.to_global(raycast.target_position) 
		
	drawshotline(startpos, endpos)
	
	
func drawshotline(startpos, endpos):
	shotline.clear_points()
	shotline.add_point(shotline.to_local(startpos))
	shotline.add_point(shotline.to_local(endpos))

	shotline.visible = true
	await get_tree().create_timer(shotduration).timeout
	shotline.visible = false
	
