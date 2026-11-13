extends Area2D

var speed = randf_range(300, 1000)

@onready var path = get_node("/root/Game/Path2D/PathFollow2D")

var punkt
var wall 

func _ready() -> void:
	var wall = randi_range(1, 4)
	if wall == 1:
		punkt = Vector2(randf_range(-200,1400), -200)
	elif wall == 2:
		punkt = Vector2(1400, randf_range(-200,800)) 
	elif wall == 3:
		punkt = Vector2(randf_range(-200,1400), 800)
	elif wall == 4:
		punkt = Vector2(-200, randf_range(-200,800)) 

func _process(delta):
	global_position = global_position.move_toward(punkt, speed * delta)
	
	if global_position == punkt:
		queue_free()
