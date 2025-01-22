extends CharacterBody2D

var snowball = preload("res://scenes/enemies/snowball.tscn")
@onready var timer: Timer = $Timer
var dir = 1
@onready var left: Area2D = $Left
@onready var right: Area2D = $Right

func _process(delta: float) -> void:
	if dir == 1:
		$AnimatedSprite2D.flip_h = false
	if dir == -1:
		$AnimatedSprite2D.flip_h = true

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()


func _on_timer_timeout() -> void:
	var new_ball = snowball.instantiate()
	add_child(new_ball)
	timer.stop()
	timer.start()


func _on_left_area_entered(area: Area2D) -> void:
	dir = -1


func _on_right_area_entered(area: Area2D) -> void:
	dir = 1
