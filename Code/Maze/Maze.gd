extends Node3D
class_name Maze

var speed = 45 # degrees / sec.

func _process(delta: float) -> void:
	if Input.is_action_pressed("quit"):
		get_tree().quit()
	
	if Input.is_action_pressed("tilt_north"):
		rotation_degrees.x -= speed * delta
	if Input.is_action_pressed("tilt_east"):
		rotation_degrees.z -= speed * delta
	if Input.is_action_pressed("tilt_south"):
		rotation_degrees.x += speed * delta
	if Input.is_action_pressed("tilt_west"):
		rotation_degrees.z += speed * delta




# Fill he grid with rooms.
func generate(width, depth): # unit is plot.
	pass
