extends CharacterBody2D

const SPEED = 300
var dir = 1
var attack_power = 1
var wait = false
@onready var walk_timer: Timer = $"Walk Timer"
@onready var walk_cooldown: Timer = $"Walk Cooldown"

func _ready() -> void:
	$Randomizer.wait_time = randf_range(0,3)
	$Randomizer.start()
func _process(delta: float) -> void:
	if dir == -1:
		$AnimatedSprite2D.flip_h = true
	elif dir == 1:
		$AnimatedSprite2D.flip_h  = false
	
	velocity.x = dir * SPEED * delta
	velocity.x = clamp(velocity.x, -SPEED, SPEED)
	
	if not wait:
		move_and_slide()

func _on_walk_timer_timeout() -> void:
	walk_cooldown.start()
	wait = true
	walk_timer.stop()


func _on_walk_cooldown_timeout() -> void:
	walk_timer.start()
	wait = false
	dir = -dir
	walk_cooldown.stop()


func _on_randomizer_timeout() -> void:
	walk_timer.start()
