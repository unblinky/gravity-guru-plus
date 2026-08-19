extends Node3D
class_name Room

var walls: Array

func _ready() -> void:
	#walls = [$NorthWall, $SouthWall, $EastWall, $WestWall]
	walls.append($NorthWall)
	walls.append($EastWall)
	walls.append($SouthWall)
	walls.append($WestWall)


func get_random_direction() -> Vector3:
	var rando: int = randi_range(0 ,3)
	
	match walls[rando].direction:
		Wall.Direction.NORTH:
			return Vector3.FORWARD
		Wall.Direction.EAST:
			return Vector3.RIGHT
		Wall.Direction.SOUTH:
			return Vector3.BACK
		Wall.Direction.WEST:
			return Vector3.LEFT
	
	return Vector3.ZERO
