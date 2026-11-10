extends Area2D

var score = 0

signal item_collected(points)

func _on_body_entered(body: Node2D) -> void:
	queue_free()
	item_collected.emit(1)
