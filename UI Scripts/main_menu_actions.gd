extends Node2D

var show_tutorial = false

# Cargar asset de boton de sonido
func _ready() -> void:
	if global_variables.audio_enabled:
		$Sound_button.texture_normal = load("res://UI/UI Sound on.png")
		$Sound_button.texture_hover = load("res://UI/UI Sound on selected.png")
	else:
		$Sound_button.texture_normal = load("res://UI/UI Sound off.png")
		$Sound_button.texture_hover = load("res://UI/UI Sound off selected.png")

# Funcionamiento de botones de menu principal

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Juego_normal.tscn")


func _on_tutorial_button_pressed() -> void:
	show_tutorial = not show_tutorial
	get_parent().get_node("UI Info").visible = show_tutorial


func _on_sound_button_pressed() -> void:
	if global_variables.audio_enabled:
		global_variables.audio_enabled = false
		$Sound_button.texture_normal = load("res://UI/UI Sound off.png")
		$Sound_button.texture_hover = load("res://UI/UI Sound off selected.png")
	else:
		global_variables.audio_enabled = true
		$Sound_button.texture_normal = load("res://UI/UI Sound on.png")
		$Sound_button.texture_hover = load("res://UI/UI Sound on selected.png")
