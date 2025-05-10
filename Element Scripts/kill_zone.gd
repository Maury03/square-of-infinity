extends Area2D

# Elimina al jugador si sale de la pantalla
# player.defeat no funciona si player.is_powered es true
func _on_player_out(player: Node2D) -> void:
	if player.is_powered:
		player.power_down()
	player.defeat()
