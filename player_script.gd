extends CharacterBody2D

# Player movement stuff
const SPEED = 450.0
const FRICTION = 50
const JUMP_VELOCITY = -700.0

# Movement process
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	if direction and not is_defeated:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION)

	move_and_slide()

# Player fighting stuff
var is_powered = false
var is_defeated = false
