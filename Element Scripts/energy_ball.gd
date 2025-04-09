extends RigidBody2D

func _on_player_entered(player: Node) -> void:
	if not player.is_defeated:
		player.power_up()
		queue_free()


func _on_screen_exit() -> void:
	queue_free()
