extends RigidBody3D
class_name Marble


var starting_position: Vector3


## Kill floor.
func _process(_delta: float) -> void:
	if position.y < -100:
		position = starting_position
		linear_velocity = Vector3.ZERO
