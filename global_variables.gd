extends Node

# Sonido
var audio_enabled = true

# Conteo de niveles superados
var player_score = 0

# Variables de dificultad
var proyectile_speed = 500
var proyectile_spawn_rate = 10
var orb_spawn_time = 5

# Array de diccionarios de proyectil para referencia a cada escena y cantidad de nucleos generados
var proyectile_array = []

# Llenado del array con todos los proyectiles
func fill_array() -> void:
	var proyectile_scenes = [
		"res://Proyectiles/projectile_straight.tscn",
		"res://Proyectiles/projectile_homing.tscn",
		"res://Proyectiles/projectile_dvd.tscn"
		]
	for scene in proyectile_scenes:
		var packed_scene = load(scene)
		if packed_scene:
			var temp_instance = packed_scene.instantiate()
			var proyectile_data = {
				"spawner_sprite": temp_instance.spawner_sprite,
				"amount": temp_instance.starting_amount,
				"level_increase": temp_instance.level_increase,
				"max_limit": temp_instance.max_cores,
				"scene": packed_scene
			}
			proyectile_array.append(proyectile_data)
			temp_instance.queue_free()

# Incrementar la dificultad del juego
func increase_difficulty() -> void:
	if (player_score % 5 == 0):
		if proyectile_spawn_rate > 1: proyectile_spawn_rate -= 1
	
	proyectile_speed += 10
	
	# Aumentar cantidad de nucleos por proyectil
	for proyectile_data in proyectile_array:
		if proyectile_data.amount < proyectile_data.max_limit:
			proyectile_data.amount += proyectile_data.level_increase

# Restaurar variables a sus valores originales
func reset_variables():
	player_score = 0
	proyectile_speed = 500
	proyectile_spawn_rate = 10
	proyectile_array = []
	fill_array()
