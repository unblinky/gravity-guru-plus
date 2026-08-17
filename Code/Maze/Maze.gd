extends Node3D
class_name Maze

const ROOM = preload("res://Room/Room.tscn")

var speed = 45 # degrees / sec.

func _ready() -> void:
	var width = randi_range(1, 8)
	var height = randi_range(1, 8)
	generate(width, height)

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
func generate(width, height): # unit is plot.
	for y in height:
		for x in width:
			var room: Room = ROOM.instantiate()
			room.position = Vector3(x, 0, y) - Vector3(width * 0.5 - 0.5, 0, height * 0.5 - 0.5)
			add_child(room)
