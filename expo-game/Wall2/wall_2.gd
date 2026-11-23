extends AnimatableBody2D
class_name Wall2
@export var speed: float = 300.0
@export var margin: float = 32.0

var direction: int = 1

func _ready() -> void:
	sync_to_physics = true

func _physics_process(delta: float) -> void:
	var canvas_transform = get_canvas_transform()
	var view_size = get_viewport_rect().size
	
	var left_edge = -canvas_transform.origin.x / canvas_transform.get_scale().x
	var right_edge = left_edge + (view_size.x / canvas_transform.get_scale().x)
	
	var min_x = left_edge + margin
	var max_x = right_edge - margin
	
	# Safety check: Prevent boundaries from overlapping if margin is too big
	if min_x >= max_x:
		push_warning("Margin is too large for the screen width!")
		return
	
	# Move horizontally
	global_position.x += direction * speed * delta
	
	# Reverse direction cleanly at edges
	if direction == 1 and global_position.x >= max_x:
		global_position.x = max_x
		direction = -1
	elif direction == -1 and global_position.x <= min_x:
		global_position.x = min_x
		direction = 1
