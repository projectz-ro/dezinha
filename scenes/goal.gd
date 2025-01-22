extends Node2D

@export var ui: UI
@export var next_level: PackedScene
@onready var black_anim: AnimationPlayer = $BlackAnim
@onready var black: Sprite2D = $Black
@onready var wait: Timer = $Wait


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	black.visible = true
	black_anim.play("fade_out")

func _on_area_2d_area_entered(area: Area2D) -> void:
	black_anim.play("fade_in")
	wait.start()


func _on_wait_timeout() -> void:
	wait.stop()
	get_tree().change_scene_to_packed(next_level)
