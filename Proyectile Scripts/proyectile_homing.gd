extends Area2D

# Velocidad del proyectil, se puede utilizaer la variable
# global proyectile_speed para que aumente con la dificultad
var speed = global_variables.proyectile_speed * 0.75
var direction = Vector2.ZERO
var spawner_sprite = load("res://Assets/Homing core.png")

# Entre mas bajo sea el numero, mas rapido se genera el proyectil
var spawn_time_multiplier = 0.75

# -------Variables de dificultad legacy-------
# Cantidad de nucleos de este proyectil en primer nivel
var starting_amount = 0 # Deprecated

# Cuantos nucleos mas de este proyectil apareceran por nivel
# Con valor de 1 se suma un proyectil cada nivel, con valor de 2 se suman dos por nivel
# Con valor 0.5 se suma uno cada dos niveles
var level_increase = 0.2 # Deprecated

# Cantidad máxima de nucleos de este tipo que pueden aparecer
var max_cores = 1 # Deprecated
# --------------------------------------------

# Variables que controlan la cantidad de nucleos de este proyectil
var proyectile_start = 10
var proyectile_limit = 2
var proyectile_end = 0 # Fin de 0 indica que el proyectil nunca deja de aparecer

var player_node = Node2D

# Constantemente se mueve hacia el jugador
func _physics_process(delta):
	direction = (player_node.global_position - global_position).normalized()
	rotation = direction.angle()
	position += direction * speed * delta

# Cambiar velocidad y guardar referencia al jugador
func setup(player: Node2D):
	player_node = player
	if global_variables.proyectile_speed >= player_node.SPEED:
		speed = player_node.SPEED * 0.75

# Eliminar proyectil cuando se agote su tiempo
func _on_timer_timeout() -> void:
	queue_free()

# Hacer daño al jugador
func _on_player_entered(player: Node2D) -> void:
	player.defeat()
	queue_free()
