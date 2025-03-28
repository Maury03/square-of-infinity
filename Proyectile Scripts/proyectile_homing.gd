extends Area2D

var speed = 270
var direction = Vector2.ZERO
var spawner_sprite = load("res://Elements/Homing core.png")
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
