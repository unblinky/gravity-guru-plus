extends Node3D
class_name Maze

const ROOM = preload("res://Room/Room.tscn")
const GOAL = preload("res://Goal/Goal.tscn")
const MARBLE = preload("res://Marble/Marble.tscn")

var main: Main
var goal: Goal
var camera_offset: Vector2i
var tilt_speed = 60 # degrees / sec.


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

func plot_to_position(plot: Vector2i):
	var space: Vector3
	space.x = plot.x - camera_offset.x
	space.y = 0
	space.z = plot.y - camera_offset.y
	return space


func spawn_marble(plot: Vector2i):
	var marble: Marble = MARBLE.instantiate()
	marble.position = plot_to_position(plot)
	marble.position.y = 5.0
	marble.starting_position = marble.position
	get_parent().add_child.call_deferred(marble)
	print("MARBLE SPAWNED!!!!!")


## Fill the grid with rooms.
func generate_rooms(width: int, height: int): # unit is plot.
	var room_count: int = width * height
	camera_offset = Vector2((width / 2.0) - 0.5, (height / 2.0) - 0.5)

	var visited_plots: Array[Vector2i] # Only grows.
	var current_plot: Vector2i = Vector2i.ZERO # TODO: Randomize the starting room's plot.
	var breadcrumbs: Array[Room] # Array changes size.
	
	# First Room.
	var current_room: Room = ROOM.instantiate()
	current_room.plot = current_plot
	current_room.position.x = current_plot.x - camera_offset.x
	current_room.position.z = current_plot.y - camera_offset.y
	add_child(current_room)
	
	visited_plots.append(current_plot)
	breadcrumbs.append(current_room)
	
	## Generate Room Loop.
	# TODO: Why is the last room not spawning, intermitently.
	while visited_plots.size() < room_count:
		await get_tree().create_timer(0.1).timeout
		
		# Fill in the neighbors.
		if current_plot.y > 0:
			var north_side: Vector2i = current_plot + Vector2i.UP
			if not visited_plots.has(north_side):
				current_room.neighbors.append(north_side)
		
		if current_plot.x < width - 1:
			var east_side: Vector2i = current_plot + Vector2i.RIGHT
			if not visited_plots.has(east_side):
				current_room.neighbors.append(east_side)
		
		if current_plot.y < height - 1:
			var south_side: Vector2i = current_plot + Vector2i.DOWN
			if not visited_plots.has(south_side):
				current_room.neighbors.append(south_side)
		
		if current_plot.x > 0:
			var west_side: Vector2i = current_plot + Vector2i.LEFT
			if not visited_plots.has(west_side):
				current_room.neighbors.append(west_side)

		# Pick up a breadcrumb.
		if current_room.neighbors.is_empty():
			current_room = breadcrumbs.pop_back()
		else:
			var neighbor_plot: Vector2i = current_room.neighbors.pop_at(randi_range(0, current_room.neighbors.size() - 1))
			
			# FIXME: Next Room Code Dup?
			var next_room: Room = ROOM.instantiate()
			next_room.plot = neighbor_plot
			next_room.position.x = neighbor_plot.x - camera_offset.x
			next_room.position.z = neighbor_plot.y - camera_offset.y
			add_child(next_room)
			current_room.open_passage(next_room)
			breadcrumbs.append(next_room)
			visited_plots.append(next_room.plot)
			current_room = next_room
			current_plot = neighbor_plot
			
			## If spawning the last room...
			## Spawn Goal and Marble.
			if visited_plots.size() >= room_count:
				goal = GOAL.instantiate()
				goal.main = main
				goal.position.x = current_plot.x - camera_offset.x
				goal.position.z = current_plot.y - camera_offset.y
				add_child(goal)
				spawn_marble(visited_plots[0])
	



	
	# HACK: 
	#var upwards: float = 0.0
	
	# 3D Space.
	#var current_position: Vector3 = Vector3.ZERO
	
	#
	#
	#for y in height:
		#for x in width:
			#await get_tree().create_timer(0.5).timeout
			#var room: Room = ROOM.instantiate()
			#
			### WARNING:
			###  The removal order matters.
			###  Using counter clockwise.
			#if current_plot.x <= 0:
				#room.walls.remove_at(Wall.Direction.WEST)
			#if current_plot.y >= height - 1:
				#room.walls.remove_at(Wall.Direction.SOUTH)
			#if current_plot.x >= width - 1:
				#room.walls.remove_at(Wall.Direction.EAST)
			#if current_plot.y <= 0:
				#room.walls.remove_at(Wall.Direction.NORTH)
				#
			#
			##room.walls.erase(room.walls[0].direction)
			#add_child(room)
			#
			##var next_plot = get_random_wall(room) + current_plot
			##visited_plots.append(next_plot)
			##room.position.x = next_plot.x
			##room.position.z = next_plot.y
			#
			## TODO: Recenter the maze
			##room.position = current_position - Vector3(width * 0.5 - 0.5, 0, height * 0.5 - 0.5)
			#
			#
			## HACK: Just to see the room gen better.
			#upwards += 0.1
			#room.position.y = upwards
			#
			##current_plot = next_plot
			##current_position = room.position
#




#
##func get_random_wall(room: Room) -> Vector2i:
	#
	#while room.walls.size() > 0:
		#var rando_wall: Wall = room.walls.pick_random()
	#
		## TODO: Code dupe?
		#match rando_wall.direction:
			#Wall.Direction.NORTH:
				#if visited_plots.has(current_plot + Vector2i.UP):
					#room.walls.erase(rando_wall)
					#rando_wall.queue_free()
				#else:
					#return Vector2i.UP
			#Wall.Direction.EAST:
				#if visited_plots.has(current_plot + Vector2i.RIGHT):
					#room.walls.erase(rando_wall)
					#rando_wall.queue_free()
				#else:
					#return Vector2i.RIGHT
			#Wall.Direction.SOUTH:
				#if visited_plots.has(current_plot + Vector2i.DOWN):
					#room.walls.erase(rando_wall)
					#rando_wall.queue_free()
				#else:
					#return Vector2i.DOWN
			#Wall.Direction.WEST:
				#if visited_plots.has(current_plot + Vector2i.LEFT):
					#room.walls.erase(rando_wall)
					#rando_wall.queue_free()
				#else:
					#return Vector2i.LEFT
	#
	#print("Should never get here!")
	#return Vector2i(0, 0)
