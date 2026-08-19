extends RigidBody3D
class_name Marble

var starting_position: Vector3

func _ready() -> void:
	starting_position = position

func _process(delta: float) -> void:
	if position.y < -100:
		position = starting_position
		linear_velocity = Vector3.ZERO
