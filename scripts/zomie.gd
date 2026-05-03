extends CharacterBody2D

const SPEED = 50

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var direction := 0
var state := "idle"
var state_timer := 0.0

func _ready():
	randomize()
	_pick_idle()

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	state_timer -= delta

	if state == "idle":
		move(0)
		if state_timer <= 0:
			_pick_walk()

	elif state == "walk":
		move(direction)

		# Flip zombie
		if direction != 0:
			sprite.flip_h = direction < 0

		if state_timer <= 0:
			_pick_idle()

	move_and_slide()

func move(dir: int):
	if dir != 0:
		velocity.x = dir * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

# --- State helpers ---

func _pick_idle():
	state = "idle"
	state_timer = randf_range(5.0, 10.0)

func _pick_walk():
	state = "walk"
	direction = [-1, 1].pick_random()
	state_timer = randf_range(1.5, 3.0)
