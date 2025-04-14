extends Area2D

func _on_player_out(player: Node2D) -> void:
	if player.is_powered:
		player.power_down()
	player.defeat()
