extends CharacterBody2D

@onready var stamina_bar: ProgressBar = get_node("/root/Game/StaminaBar")
var speed = 300
var sprint_speed = 500

var stamina = 100
var stamina_drain = 50
var stamina_regen = 15
var can_regen: bool = false

var can_sprint: bool = true

var health = 3
signal health_depleted

func _physics_process(delta: float) -> void:
	movement(delta)

func movement(delta: float):
	var direction = Input.get_vector("move_left", "move_right","move_up", "move_down")
	var sprint = Input.is_action_pressed("sprint")
	
	if sprint && can_sprint:
		velocity = direction * sprint_speed
		stamina -= stamina_drain * delta
	else:
		velocity = direction * speed
		
	if stamina <= 0:
		can_sprint = false
	elif stamina > 25:
		can_sprint = true

	if speed:
		stamina += stamina_regen * delta
	stamina = clamp(stamina, 0, 100)
	stamina_bar.value = stamina
	
	if velocity.length() > 0:
		if Input.is_action_pressed("move_right"):
			$AnimatedSprite2D.play("walk")
			$AnimatedSprite2D.flip_h = false
			
		elif Input.is_action_pressed("move_left"):
			$AnimatedSprite2D.play("walk")
			$AnimatedSprite2D.flip_h = true
			
		elif Input.is_action_pressed("move_up"):
			$AnimatedSprite2D.play("walk_up")
			
		elif Input.is_action_pressed("move_down"):
			$AnimatedSprite2D.play("walk_down")
	else:
		$AnimatedSprite2D.play("idle")
		
	move_and_slide()

func take_damage(hitpoints):
	health -= hitpoints 
	if health <= 0:
		health_depleted.emit()
