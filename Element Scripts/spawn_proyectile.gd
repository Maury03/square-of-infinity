extends Node2D

@export var projectile_scene: PackedScene
@export var player: Node2D
var spawner_sprite

func _on_timer_timeout():
	if player:
		var projectile = projectile_scene.instantiate()
		projectile.global_position = global_position  # Ubicación del spawner
		projectile.setup(player)  # Disparar hacia el jugador
		get_parent().add_child(projectile)

func _ready() -> void:
	var projectile = projectile_scene.instantiate()
	$Sprite2D.texture = projectile.spawner_sprite
	$Timer.wait_time = projectile.spawn_time
	projectile.queue_free()


func _on_player_entered(player: Node2D) -> void:
	if player.is_powered:
		player.power_down()
		queue_free()
