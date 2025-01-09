extends Area2D

signal coin_collected(score_value: int)
var value = 1

func _ready() -> void:
	connect("coin_collected", GameManager.add_score)

func _on_body_entered(body: Node2D) -> void:
	emit_signal("coin_collected", value)
	queue_free()
