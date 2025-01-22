extends Area2D

func _on_body_entered(body: Node2D) -> void:
	#TODO Replace with death
	GameManager.current_score = 0	
	GameManager.current_health = GameManager.max_health
	GameManager.reload_from_checkpoint()
