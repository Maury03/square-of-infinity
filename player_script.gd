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
	if Input.is_action_just_pressed("move_up") and (is_on_floor() or is_powered):
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
var regular_sprite = load("res://Assets/Character.png")
var shielded_sprite = load("res://Assets/Character Shield.png")
var regular_trail = Color8(255, 255, 255, 128)
var shielded_trail = Color8(255, 215, 36, 128)

func power_up() -> void:
	is_powered = true
	$Sprite2D.texture = shielded_sprite
	$Line2D.default_color = shielded_trail

func power_down() -> void:
	$Sprite2D.texture = regular_sprite
	await get_tree().create_timer(0.5).timeout
	is_powered = false
	$Line2D.default_color = regular_trail

func defeat() -> void:
	if not is_defeated and not is_powered:
		is_defeated = true
		velocity.y = -300
		get_node("CollisionShape2D").set_deferred("disabled", true)
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://Menu principal.tscn")
