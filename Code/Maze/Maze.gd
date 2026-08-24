extends Node3D
class_name Maze

const ROOM = preload("res://Room/Room.tscn")

var tilt_speed = 60 # degrees / sec.

func _ready() -> void:
	var width: int = 4 # randi_range(1, 8)
	var height: int = 4 # randi_range(1, 8)
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
	var breadcrumbs: Array[Vector2] = [Vector2(0, 0)] # Array changes size.
	var visited_plots: Array[Vector2i] # Only grows.
	
	var current_plot: Vector2i = Vector2i.ZERO # TODO: Randomize the starting room's plot.
	
	
	# HACK: 
	var upwards: float = 0.0
	
	
	# 3D Space.
	#var current_position: Vector3 = Vector3.ZERO
	
	
	for y in height:
		for x in width:
			await get_tree().create_timer(0.5).timeout
			var room: Room = ROOM.instantiate()
			add_child(room)
			
			
			# TODO: Recenter the maze
			#room.position = current_position - Vector3(width * 0.5 - 0.5, 0, height * 0.5 - 0.5)
			
			#var next_plot: Vector2i = (Vector2i.RIGHT + current_plot) * room.size
			var next_plot: Vector2i = (room.get_random_direction() + current_plot) * room.size
			
			if not visited_plots.has(next_plot):
				visited_plots.append(next_plot)
			#else:
				
			
			room.position.x += next_plot.x
			room.position.z += next_plot.y
			
			# HACK: Just to see the room gen better.
			upwards += 0.1
			room.position.y = upwards
			
			current_plot = next_plot
			#current_position = room.position
