extends Node2D

var score = 0

func spawn_cheese():
	var new_cheese = preload("res://Cheese/cheese.tscn").instantiate()
	var positionX = randf_range(100,1100)
	var positionY = randf_range(100,600)
	new_cheese.global_position = Vector2(positionX, positionY)
	new_cheese.item_collected.connect(add_score)
	add_child(new_cheese)

func add_score(points):
	score += points
	$Label.text = str("score: ",score)

func spawn_saw():
	var new_saw = preload("res://Saw/saw.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_saw.global_position = %PathFollow2D.global_position
	add_child(new_saw)


func _on_saw_timer_timeout() -> void:
	spawn_saw()


func _on_cheese_timer_timeout() -> void:
	spawn_cheese()


func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true

func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_exit_pressed() -> void:
	get_tree().quit()
