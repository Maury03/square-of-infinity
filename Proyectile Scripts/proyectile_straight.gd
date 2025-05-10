extends Area2D

# Velocidad del proyectil, se puede utilizaer la variable
# global proyectile_speed para que aumente con la dificultad
var speed = global_variables.proyectile_speed
var direction = Vector2.ZERO
var spawner_sprite = load("res://Assets/Simple core.png")

# Entre mas bajo sea el numero, mas rapido se genera el proyectil
var spawn_time_multiplier = 0.25

# Cantidad de nucleos de este proyectil en primer nivel
var starting_amount = 1

# Cuantos nucleos mas de este proyectil apareceran por nivel
# Con valor de 1 se suma un proyectil cada nivel, con valor de 2 se suman dos por nivel
# Con valor 0.5 se suma uno cada dos niveles
var level_increase = 1

# Cantidad máxima de nucleos de este tipo que pueden aparecer
var max_cores = 2

var player_node = Node2D

# Constantemente se mueve en una sola direccion
func _physics_process(delta):
	position += direction * speed * delta

# Obtiene su direccion inicial en base a la posicion del jugador
func setup(player: Node2D):
	direction = (player.global_position - global_position).normalized()

# Al salir de la pantalla despawnea
func _on_left_screen() -> void:
	await get_tree().create_timer(2).timeout
	queue_free()

# Hacer daño al jugador
func _on_player_entered(player: Node2D) -> void:
	player.defeat()
	queue_free()
