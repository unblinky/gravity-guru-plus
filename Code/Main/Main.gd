extends Node
class_name Main

const MAZE = preload("res://Maze/Maze.tscn")

var maze: Maze
var maze_witdh: int = 1
var maze_height: int = 1

func _ready() -> void:
	make_maze()

func make_maze():
	if maze != null:
		maze.queue_free()
	
	maze_witdh += 1
	maze_height += 1
	maze = MAZE.instantiate()
	maze.main = self
	add_child(maze)
	
	maze.generate_rooms(maze_witdh, maze_height)
	
