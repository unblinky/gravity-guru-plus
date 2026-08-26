extends Node3D
class_name Room

@onready var north_wall: Wall = $NorthWall
@onready var east_wall: Wall = $EastWall
@onready var south_wall: Wall = $SouthWall
@onready var west_wall: Wall = $WestWall

var walls: Array[Wall]
var size: Vector2i = Vector2i(1, 1) # Meters. TODO: Support non-uniform room sizes and positional floats.
var plot: Vector2i
var neighbors: Array[Vector2i]


func _ready() -> void:
	#walls = [$NorthWall, $SouthWall, $EastWall, $WestWall]
	walls.append(north_wall)
	walls.append(east_wall)
	walls.append(south_wall)
	walls.append(west_wall)


#
#func open_passage(next_room: Room):
	## Heading North
	#if next_room.plot.y < self.plot.y:
		#north_wall.disable()
		#walls.erase(north_wall)
		#next_room.remove_wall(Vector2i.DOWN)
	#
	#d
	## Heading East
	#if next_room.plot.x > self.plot.x:
		#self.remove_wall(Vector2i.RIGHT)
		#next_room.remove_wall(Vector2i.LEFT)
	#
	## Heading South
	#if next_room.plot.y > self.plot.y:
		#self.remove_wall(Vector2i.DOWN)
		#next_room.remove_wall(Vector2i.UP)
	#
	## Heading West
	#if next_room.plot.x < self.plot.x:
		#self.remove_wall(Vector2i.LEFT)
		#next_room.remove_wall(Vector2i.RIGHT)
