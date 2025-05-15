extends Node2D

@export var power_orb: PackedScene
var rng = RandomNumberGenerator.new()
var player: CharacterBody2D
var camera_rect: Rect2
var cores_remaining = 0

# Se llenan las variables y se generan los nucleos
func _ready() -> void:
	camera_rect = get_camera_view_rect()
	$OrbTimer.wait_time = global_variables.orb_spawn_time
	player = $Player
	global_variables.choose_proyectiles()
	generate_selected_cores()

# Generación de orbes de energía
func _on_orb_timer_timeout() -> void:
	var orbx = rng.randf_range(camera_rect.position.x, camera_rect.end.x)
	var orby = camera_rect.position.y
	var orb_position = Vector2(orbx, orby)
	var generated_orb = power_orb.instantiate()
	generated_orb.global_position = orb_position
	add_child(generated_orb)

# Generación de nucleos (legacy)
func generate_cores() -> void:
	for proyectile_data in global_variables.proyectile_array:
		var counter = 0
		while counter < floor(proyectile_data.amount):
			var corex = rng.randf_range(camera_rect.position.x, camera_rect.end.x)
			var corey = rng.randf_range(camera_rect.position.y, camera_rect.end.y)
			var new_core = load("res://Game Elements/spawner_proyectile.tscn").instantiate()
			new_core.projectile_scene = proyectile_data.scene
			new_core.player = player
			new_core.global_position = Vector2(corex, corey)
			add_child(new_core)
			cores_remaining += 1
			counter += 1

# Generación de nucleos aleatorios
func generate_selected_cores() -> void:
	for chosen_proyectile in global_variables.chosen_proyectiles:
		var corex = rng.randf_range(camera_rect.position.x, camera_rect.end.x)
		var corey = rng.randf_range(camera_rect.position.y, camera_rect.end.y)
		var new_core = load("res://Game Elements/spawner_proyectile.tscn").instantiate()
		new_core.projectile_scene = chosen_proyectile.scene
		new_core.player = player
		new_core.global_position = Vector2(corex, corey)
		add_child(new_core)
		cores_remaining += 1

# Obtener area de la camara
func get_camera_view_rect() -> Rect2:
	var camera = $Camera2D
	var screen_size = get_viewport().get_visible_rect().size
	var zoomed_size = screen_size * camera.zoom
	var camera_pos = camera.get_global_position()
	var half_zoomed = zoomed_size * 0.5

	return Rect2(camera_pos - half_zoomed, zoomed_size)

# Proceso de derrota del jugador
func finish_game() -> void:
	$EndingScreen.visible = true
	$EndingScreen/Label.text = "Avanzaste " + str(global_variables.player_score) + " niveles"
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://Menu principal.tscn")

# Maneja audios al fundir un nucleo y cambio de nivel al destruir todos
func destroyed_core() -> void:
	cores_remaining -= 1
	if cores_remaining == 0:
		global_variables.player_score +=1
		global_variables.increase_difficulty()
		if global_variables.audio_enabled:
			global_sound.stream = load("res://Sound Effects/teleport.wav")
			global_sound.play(0.0)
		get_tree().change_scene_to_file("res://Juego_normal.tscn")
	else:
		$OrbTimer.wait_time = $OrbTimer.wait_time / 2
		if global_variables.audio_enabled:
			$AudioStreamPlayer.stream = load("res://Sound Effects/power_down.wav")
			$AudioStreamPlayer.play(0.0)
