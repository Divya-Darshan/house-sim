extends AnimatedSprite2D




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	get_tree().create_timer(7.0).timeout
	play("loop")
	get_tree().create_timer(7.0).timeout
	play("idle")
