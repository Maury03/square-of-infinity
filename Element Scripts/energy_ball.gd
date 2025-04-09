extends RigidBody2D

func _on_player_entered(player: Node) -> void:
	player.power_up()
	queue_free()


func _on_screen_exit() -> void:
	get_parent().get_node("OrbTimer").start()
	queue_free()
