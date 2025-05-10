extends Node2D

@export var projectile_scene: PackedScene
@export var player: Node2D
var spawner_sprite

# Spawnear nuevo proyectil
func _on_timer_timeout():
	if player:
		var projectile = projectile_scene.instantiate()
		projectile.global_position = global_position  # Ubicación del spawner
		projectile.setup(player)  # Disparar hacia el jugador
		get_parent().add_child(projectile)
		if global_variables.audio_enabled:
			$AudioStreamPlayer.stream = load("res://Sound Effects/proyectile_spawn.wav")
			$AudioStreamPlayer.play(0.0)

# Configurar spawner en base al proyectil elegido
func _ready() -> void:
	var rng = RandomNumberGenerator.new()
	var projectile = projectile_scene.instantiate()
	$Sprite2D.texture = projectile.spawner_sprite
	$Timer.wait_time = global_variables.proyectile_spawn_rate * projectile.spawn_time_multiplier
	projectile.queue_free()
	await get_tree().create_timer(rng.randf_range(0.0, 1.0)).timeout
	$Timer.start()

# Destruccion del nucleo
func _on_player_entered(player: Node2D) -> void:
	if player.is_powered:
		player.power_down()
		get_parent().destroyed_core()
		queue_free()
