extends Line2D

@export var length: int
var point

func _physics_process(delta):
	point = get_parent().global_position
	add_point(point)

	if points.size() > length:
		remove_point(0)
