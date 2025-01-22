class_name Lantern
extends Node2D

@export var on = true

func _ready() -> void:
	if !on:
		$AnimatedSprite2D.animation = "off"
		$PointLight2D.visible = false
	else:
		$AnimationPlayer.play("flicker")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if !on:
		on = true
		$AnimationPlayer.play("flicker")
		$AnimatedSprite2D.animation = "default"
		$PointLight2D.visible = true
		GameManager.checkpointed = true
		GameManager.checkpoint_position = position
