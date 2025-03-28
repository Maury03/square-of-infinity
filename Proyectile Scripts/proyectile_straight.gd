extends Area2D

var speed = 300
var direction = Vector2.ZERO
var spawner_sprite = load("res://Elements/Simple core.png")
var spawn_time = 1

func _physics_process(delta):
	position += direction * speed * delta

func setup(player: Node2D):
	direction = (player.global_position - global_position).normalized()


func _on_left_screen() -> void:
	queue_free()
