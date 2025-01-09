class_name Pickup
extends Node

enum Type {COIN, MEMORY, HEALTH}

@export var pickup_type: Type



func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
