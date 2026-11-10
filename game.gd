extends Node2D

var score = 0

func spawn_cheese():
	var new_cheese = preload("res://Cheese/cheese.tscn").instantiate()
	var positionX = randf_range(100,1100)
	var positionY = randf_range(100,600)
	new_cheese.global_position = Vector2(positionX, positionY)
	new_cheese.item_collected.connect(add_score)
	add_child(new_cheese)

func _on_timer_timeout() -> void:
	spawn_cheese()

func add_score(points):
	score += points
	print("score: ", score)
	$Label.text = str("wynik: ",score)
