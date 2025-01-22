class_name Letter
extends Node2D

@export var heading: String
@export_multiline var body: String
@export var ui: UI

func _on_area_2d_area_entered(area: Area2D) -> void:
	get_tree().paused = true 
	ui.show_letter(heading, body)
	queue_free()
