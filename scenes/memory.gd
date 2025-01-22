extends Area2D

signal memory_collected

func _ready() -> void:
	self.connect("body_entered", _on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	# TODO run effects etc
	emit_signal("memory_collected")
	GameManager.add_memory(1)
	queue_free()
