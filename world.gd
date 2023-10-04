extends Node2D


func _on_sec_detector_body_entered(body):
	if body.name == "player":
		get_node("sec label").visible = true
