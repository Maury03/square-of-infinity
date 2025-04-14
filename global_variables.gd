extends Node

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
	var proyectile_folder = "res://Proyectiles"
	var dir = DirAccess.open(proyectile_folder)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir() and file_name.ends_with(".tscn"):
				var scene_path = proyectile_folder + "/" + file_name
				var packed_scene = load(scene_path)
				if packed_scene:
					var temp_instance = packed_scene.instantiate()
					var proyectile_data = {
						"spawner_sprite": temp_instance.spawner_sprite,
						"amount": temp_instance.starting_amount,
						"level_increase": temp_instance.level_increase,
						"scene": packed_scene
					}
					proyectile_array.append(proyectile_data)
					temp_instance.queue_free()
			file_name = dir.get_next()
		dir.list_dir_end()

# Incrementar la dificultad del juego
func increase_difficulty() -> void:
	if (player_score % 5 == 0):
		if proyectile_spawn_rate > 1: proyectile_spawn_rate -= 1
	
	# Aumentar cantidad de nucleos por proyectil
	for proyectile_data in proyectile_array:
		proyectile_data.amount += proyectile_data.level_increase

func reset_variables():
	player_score = 0
	proyectile_speed = 500
	proyectile_spawn_rate = 10
	proyectile_array = []
	fill_array()
