extends Node3D
class_name Maze

const ROOM = preload("res://Room/Room.tscn")

var tilt_speed = 60 # degrees / sec.

func _ready() -> void:
	var width = randi_range(1, 8)
	var height = randi_range(1, 8)
	generate(width, height)

func _process(delta: float) -> void:
	if Input.is_action_pressed("quit"):
		get_tree().quit()
	
	if Input.is_action_pressed("tilt_north"):
		rotation_degrees.x -= tilt_speed * delta
	if Input.is_action_pressed("tilt_east"):
		rotation_degrees.z -= tilt_speed * delta
	if Input.is_action_pressed("tilt_south"):
		rotation_degrees.x += tilt_speed * delta
	if Input.is_action_pressed("tilt_west"):
		rotation_degrees.z += tilt_speed * delta


# Fill he grid with rooms.
func generate(width, height): # unit is plot.
	#var room_count: int = width * height
	
	# Plots on our grid.
	var breadcrumbs: Array[Vector2] = [Vector2(0, 0)]
	
	# 3D Space.
	var current_position: Vector3 = Vector3.ZERO
	
	for y in height:
		for x in width:
			await get_tree().create_timer(0.5).timeout
			var room: Room = ROOM.instantiate()
			add_child(room)
			
			# TODO: Recenter the maze
			#room.position = current_position - Vector3(width * 0.5 - 0.5, 0, height * 0.5 - 0.5)
			room.position += current_position + room.get_random_direction()
			current_position = room.position
