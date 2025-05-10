extends Area2D

# Velocidad del proyectil, se puede utilizaer la variable
# global proyectile_speed para que aumente con la dificultad
var speed = global_variables.proyectile_speed
var direction = Vector2.ZERO
var spawner_sprite = load("res://Assets/Dvd Core.png")

# Entre mas bajo sea el numero, mas rapido se genera el proyectil
var spawn_time_multiplier = 0.25

# Cantidad de nucleos de este proyectil en primer nivel
var starting_amount = 0

# Cuantos nucleos mas de este proyectil apareceran por nivel
# Con valor de 1 se suma un proyectil cada nivel, con valor de 2 se suman dos por nivel
# Con valor 0.5 se suma uno cada dos niveles
var level_increase = 0.5

# Cantidad máxima de nucleos de este tipo que pueden aparecer
var max_cores = 2

var bounces = 0
var bouncable = true
var pantalla: Rect2

func _process(delta: float) -> void:
	if bounces > 3:
		bouncable = false

func _ready() -> void:
	# Obtener tamaño de la ventana
	pantalla = get_parent().get_camera_view_rect()

# Movimiento del proyectil
func _physics_process(delta):
	position += direction * speed * delta
	if bouncable:
		# Rebote en bordes horizontales
		if position.x < pantalla.position.x or position.x > pantalla.end.x:
			bounces += 1
			direction.x *= -1
			position.x = clamp(position.x, pantalla.position.x, pantalla.end.x)

		# Rebote en bordes verticales
		if position.y < pantalla.position.y or position.y > pantalla.end.y:
			bounces += 1
			direction.y *= -1
			position.y = clamp(position.y, pantalla.position.x, pantalla.end.y)
	else:
		# Rebote en bordes horizontales
		if position.x < pantalla.position.x or position.x > pantalla.end.x:
			await get_tree().create_timer(2).timeout
			queue_free()

		# Rebote en bordes verticales
		if position.y < pantalla.position.y or position.y > pantalla.end.y:
			await get_tree().create_timer(2).timeout
			queue_free()

# Obtener direccion del jugador
func setup(player: Node2D):
	direction = (player.global_position - global_position).normalized()

func _on_player_entered(player: Node2D) -> void:
	player.defeat()
	queue_free()
