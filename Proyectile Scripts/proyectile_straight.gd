extends Area2D

var speed = 300
var direction = Vector2.ZERO
var spawner_sprite = load("res://Assets/Simple core.png")
var spawn_time = 1

func _physics_process(delta):
	position += direction * speed * delta

func setup(player: Node2D):
	direction = (player.global_position - global_position).normalized()


func _on_left_screen() -> void:
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
