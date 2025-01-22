class_name FloatComponent
extends Node

@export var root: Node2D
@export var distance: float = 2
@export var speed: float = 5
@onready var r_start: Timer = Timer.new()
var up: bool
var start_pos: Vector2
var start: bool = false

func _ready() -> void:
	start_pos = root.global_position
	r_start.wait_time = randf_range(0,1)
	add_child(r_start)
	r_start.connect("timeout", _on_r_start_timeout)
	r_start.start()

func _physics_process(delta: float) -> void:
	if start:
		if up:
			if root.global_position.y > start_pos.y - distance:
				root.global_position.y -= speed * delta
			else:
				up = false
		else:
			if root.global_position.y < start_pos.y + distance:
				root.global_position.y += speed * delta
			else:
				up = true

func _on_r_start_timeout():
	start = true
