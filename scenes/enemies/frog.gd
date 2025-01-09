extends CharacterBody2D

func _process(delta: float) -> void:
	if $MoveComponent.move.is_stopped():
		if $AnimationPlayer.is_playing():
			$AnimationPlayer.animation_set_next("jump", "idle")
		else:
			$AnimationPlayer.play("idle")
	else:
		$AnimationPlayer.play("jump")
