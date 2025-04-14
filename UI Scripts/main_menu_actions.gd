extends Node2D

var show_tutorial = false

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Juego_normal.tscn")


func _on_tutorial_button_pressed() -> void:
	show_tutorial = not show_tutorial
	get_parent().get_node("UI Info").visible = show_tutorial
