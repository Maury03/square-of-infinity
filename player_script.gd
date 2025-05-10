extends CharacterBody2D

# Variables de movimiento
const SPEED = 450.0
const FRICTION = 50
const JUMP_VELOCITY = -650.0

# Proceso de movimiento
func _physics_process(delta: float) -> void:
	# Aplicar gravedad
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Salto del jugador
	if Input.is_action_just_pressed("move_up") and (is_on_floor() or is_powered):
		velocity.y = JUMP_VELOCITY

	# Movimiento lateral y aplicacion de friccion
	var direction := Input.get_axis("move_left", "move_right")
	if direction and not is_defeated:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION)

	move_and_slide()

# Variables de poder
var is_powered = false
var is_defeated = false
var regular_sprite = load("res://Assets/Character.png")
var shielded_sprite = load("res://Assets/Character Shield.png")
var regular_trail = Color8(255, 255, 255, 128)
var shielded_trail = Color8(255, 215, 36, 128)

# Darle poder al jugador
func power_up() -> void:
	if global_variables.audio_enabled:
		$AudioStreamPlayer.stream = load("res://Sound Effects/power_up.wav")
		$AudioStreamPlayer.play(0.0)
	is_powered = true
	$Sprite2D.texture = shielded_sprite
	$Line2D.default_color = shielded_trail

# Quitarle poder al jugador
func power_down() -> void:
	$Sprite2D.texture = regular_sprite
	await get_tree().create_timer(0.3).timeout
	is_powered = false
	get_parent().get_node("OrbTimer").start()
	$Line2D.default_color = regular_trail

# Derrotar jugador si no tiene poder
func defeat() -> void:
	if not is_defeated and not is_powered:
		if global_variables.audio_enabled:
			$AudioStreamPlayer.stream = load("res://Sound Effects/player_defeat.wav")
			$AudioStreamPlayer.play(0.0)
		is_defeated = true
		velocity.y = -300
		get_node("CollisionShape2D").set_deferred("disabled", true)
		get_parent().finish_game()
