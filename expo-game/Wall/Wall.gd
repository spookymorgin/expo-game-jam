extends RigidBody2D
class_name wall
 

@export var speed: float = 300.0
@export var margin: float = 32.0 

var direction: int = 1 
var screen_width: float

func _ready() -> void:
	screen_width = get_viewport_rect().size.x
	
	gravity_scale = 0.0
	lock_rotation = true

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if global_position.x >= screen_width - margin:
		direction = -1
	elif global_position.x <= margin:
		direction = 1
	
	state.linear_velocity.x = direction * speed
