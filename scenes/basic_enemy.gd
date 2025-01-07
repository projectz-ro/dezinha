extends CharacterBody2D

const SPEED = 600
var dir = 1
var attack_power = 1
var waiting = true
@onready var ray_right: RayCast2D = $RayRight
@onready var ray_left: RayCast2D = $RayLeft
@onready var wait: Timer = $Wait
@onready var walk: Timer = $Walk

func _ready() -> void:
	$Randomizer.wait_time = randf_range(0,3)
	$Randomizer.start()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	
	if dir == 1 && ray_right.is_colliding():
		dir = -1
		$AnimatedSprite2D.flip_h = true
	elif dir == -1 && ray_left.is_colliding():
		dir = 1
		$AnimatedSprite2D.flip_h  = false
	
	if not waiting:
		$AnimationPlayer.play("jump")
		velocity.x = dir * SPEED * delta
		velocity.x = clamp(velocity.x, -SPEED, SPEED)
	else:
		if $AnimationPlayer.is_playing():
			$AnimationPlayer.animation_set_next("jump","idle")
		else:
			$AnimationPlayer.play("idle")
		velocity.x = 0
	move_and_slide()

func _on_walk_timeout() -> void:
	walk.stop()
	wait.start()
	waiting = true


func _on_wait_timeout() -> void:
	wait.stop()
	waiting = false
	walk.start()
	
func _on_randomizer_timeout() -> void:
	wait.start()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.collision_layer == 4096:
		queue_free()
