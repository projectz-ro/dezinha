extends Area2D

signal memory_collected

func _ready() -> void:
	self.connect("body_entered", _on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	# TODO run effects etc
	$AudioStreamPlayer.play(0)
	visible = false


func _on_audio_stream_player_finished() -> void:
	GameManager.add_memory(1)
	emit_signal("memory_collected")
	queue_free()
