extends StaticBody3D
class_name Wall

enum Direction {
	NORTH,
	EAST,
	SOUTH,
	WEST
}

@onready var collider: CollisionShape3D = $CollisionShape3D
@export var direction: Direction
