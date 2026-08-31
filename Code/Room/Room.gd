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


func open_passage(next_room: Room):
	## Heading North
	if next_room.plot.y < self.plot.y:
		north_wall.collider.disabled = true
		walls.erase(north_wall)
		north_wall.hide()
		
		next_room.south_wall.collider.disabled = true
		next_room.walls.erase(south_wall)
		next_room.south_wall.hide()


	## Heading East
	if next_room.plot.x > self.plot.x:
		east_wall.collider.disabled = true
		walls.erase(east_wall)
		east_wall.hide()
		
		next_room.west_wall.collider.disabled = true
		next_room.walls.erase(west_wall)
		next_room.west_wall.hide()


	## Heading South
	if next_room.plot.y > self.plot.y:
		south_wall.collider.disabled = true
		walls.erase(south_wall)
		south_wall.hide()
		
		next_room.north_wall.collider.disabled = true
		next_room.walls.erase(north_wall)
		next_room.north_wall.hide()


	## Heading West
	if next_room.plot.x < self.plot.x:
		west_wall.collider.disabled = true
		walls.erase(west_wall)
		west_wall.hide()
		
		next_room.east_wall.collider.disabled = true
		next_room.walls.erase(east_wall)
		next_room.east_wall.hide()
