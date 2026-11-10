extends Area2D

var score = 0

func _on_body_entered(body: Node2D) -> void:
	queue_free()
