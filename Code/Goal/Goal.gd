extends Area3D
class_name Goal

func _ready() -> void:
	body_entered.connect(on_body_entered)


func on_body_entered(body: Node3D):
	if body is Marble:
		print("MARBLE GoALL!!!!")
		# TODO: What is the level difficulty?
		get_tree().reload_current_scene.call_deferred()
