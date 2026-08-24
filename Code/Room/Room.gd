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
