extends Node2D

@export var power_orb: PackedScene
var rng = RandomNumberGenerator.new()
var camera_rect: Rect2

func _ready() -> void:
	camera_rect = get_camera_view_rect($Camera2D)

func _on_orb_timer_timeout() -> void:
	var orbx = rng.randf_range(camera_rect.position.x, camera_rect.end.x)
	var orby = camera_rect.position.y
	var orb_position = Vector2(orbx, orby)
	var generated_orb = power_orb.instantiate()
	generated_orb.global_position = orb_position
	add_child(generated_orb)

func get_camera_view_rect(camera: Camera2D) -> Rect2:
	var screen_size = get_viewport().get_visible_rect().size
	var zoomed_size = screen_size * camera.zoom
	var camera_pos = camera.get_global_position()
	var half_zoomed = zoomed_size * 0.5

	return Rect2(camera_pos - half_zoomed, zoomed_size)
