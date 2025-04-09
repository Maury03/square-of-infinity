extends Area2D

func _on_player_out(player: Node2D) -> void:
	if not player.is_defeated:
		get_tree().change_scene_to_file("res://Menu principal.tscn")
