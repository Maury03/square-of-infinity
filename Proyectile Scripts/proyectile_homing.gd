extends Area2D

# Velocidad del proyectil, se puede utilizaer la variable
# global proyectile_speed para que aumente con la dificultad
var speed = global_variables.proyectile_speed * 0.75
var direction = Vector2.ZERO
var spawner_sprite = load("res://Assets/Homing core.png")

# Entre mas bajo sea el numero, mas rapido se genera el proyectil
var spawn_time_multiplier = 0.75

# Cantidad de nucleos de este proyectil en primer nivel
var starting_amount = 0

# Cantidad máxima de nucleos de este tipo que pueden aparecer
var max_cores = 1

# Cuantos nucleos mas de este proyectil apareceran por nivel
# Con valor de 1 se suma un proyectil cada nivel, con valor de 2 se suman dos por nivel
# Con valor 0.5 se suma uno cada dos niveles
var level_increase = 0.2

var player_node = Node2D


func _physics_process(delta):
	direction = (player_node.global_position - global_position).normalized()
	rotation = direction.angle()
	position += direction * speed * delta

func setup(player: Node2D):
	player_node = player
	if global_variables.proyectile_speed >= player_node.SPEED:
		speed = player_node.SPEED * 0.75


func _on_timer_timeout() -> void:
	queue_free()


func _on_player_entered(player: Node2D) -> void:
	player.defeat()
	queue_free()
