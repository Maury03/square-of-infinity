extends Area2D

var speed = 300
var direction = Vector2.ZERO
var spawner_sprite = load("res://Assets/Simple core.png")
var spawn_time = 1
var has_collided = false

func _physics_process(delta):
	position += direction * speed * delta

func setup(player: Node2D):
	direction = (player.global_position - global_position).normalized()


func _on_left_screen() -> void:
	if not has_collided:
		queue_free()


func _on_player_entered(player: Node2D) -> void:
	player.defeat()
	queue_free()
