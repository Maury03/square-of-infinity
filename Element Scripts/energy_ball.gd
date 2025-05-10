extends RigidBody2D

# Otorga poder al jugador
func _on_player_entered(player: Node) -> void:
	player.power_up()
	queue_free()

# Si sale de la pantalla se genera otro orbe
func _on_screen_exit() -> void:
	get_parent().get_node("OrbTimer").start()
	queue_free()
