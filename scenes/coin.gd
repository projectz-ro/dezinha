extends Area2D

signal collected(score_value: int)
var value = 1

func _ready() -> void:
	connect("collected", GameManager.add_score)
	
func _on_body_entered(body: Node2D) -> void:
	emit_signal("collected", value)
	queue_free()
