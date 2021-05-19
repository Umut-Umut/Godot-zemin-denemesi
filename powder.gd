extends AnimatedSprite

func _on_powder_animation_finished():
	queue_free()
