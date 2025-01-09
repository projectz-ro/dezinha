class_name Lantern
extends Node2D

@export var on = true

func _process(delta: float) -> void:
	if !on:
		$AnimatedSprite2D.animation = "off"
		$PointLight2D.visible = false
