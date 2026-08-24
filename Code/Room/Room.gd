extends Node3D
class_name Room

var walls: Array
var size: Vector2i = Vector2i(1, 1) # Meters. TODO: Support non-uniform room sizes and positional floats.

func _ready() -> void:
	#walls = [$NorthWall, $SouthWall, $EastWall, $WestWall]
	walls.append($NorthWall)
	walls.append($EastWall)
	walls.append($SouthWall)
	walls.append($WestWall)


func get_random_direction() -> Vector2i:
	var rando: int = randi_range(0 ,walls.size() - 1)
	
	match walls[rando].direction:
		Wall.Direction.NORTH:
			return Vector2i.UP
		Wall.Direction.EAST:
			return Vector2i.RIGHT
		Wall.Direction.SOUTH:
			return Vector2i.DOWN
		Wall.Direction.WEST:
			return Vector2i.LEFT
	
	walls.remove_at(rando)
	queue_free()
	#walls.erase(walls[rando])
	
	return Vector2i.ZERO
