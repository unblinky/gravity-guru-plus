extends Area3D
class_name Goal

func _ready() -> void:
	body_entered.connect(on_body_entered)


func on_body_entered(body: Node3D):
	print("GoALL!!!!")
