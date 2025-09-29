extends Camera2D

@export var speed: float = 200.0
var velocity: float = 0.0

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		velocity = -speed
	elif Input.is_action_pressed("ui_right"):
		velocity = speed
	else:
		velocity = 0

	position.x += velocity * delta
