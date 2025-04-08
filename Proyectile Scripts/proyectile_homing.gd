extends Area2D

var speed = 270
var direction = Vector2.ZERO
var spawner_sprite = load("res://Assets/Homing core.png")
var spawn_time = 3
var player_node = Node2D

func _physics_process(delta):
	direction = (player_node.global_position - global_position).normalized()
	rotation = direction.angle()
	position += direction * speed * delta

func setup(player: Node2D):
	player_node = player


func _on_timer_timeout() -> void:
	queue_free()


func _on_player_entered(player: Node2D) -> void:
	if not player.is_defeated:
		visible = false
		player.is_defeated = true
		player.velocity.y = -300
		player.get_node("CollisionShape2D").set_deferred("disabled", true)
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://Menu principal.tscn")
	else:
		pass
