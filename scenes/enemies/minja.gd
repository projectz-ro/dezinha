extends CharacterBody2D

@onready var right_detect: RayCast2D = $RightDetect
@onready var left_detect: RayCast2D = $LeftDetect
@onready var minja: AnimatedSprite2D = $Minja
@onready var rock: Sprite2D = $Rock
@onready var shoot: Timer = $Shoot
@onready var appear: Timer = $Appear
@onready var cooldown: Timer = $Cooldown
@onready var disappear: Timer = $Disappear

var star = preload("res://scenes/enemies/minja_star.tscn")
var dir = 1
var disguised = true
var appeared = false
var shooting = false

func _process(delta: float) -> void:
	if disguised:
		if right_detect.is_colliding() or left_detect.is_colliding():
			minja.visible = true
			if appeared == false:
				minja.play("vanish")
				minja.animation_finished.connect(_on_appear_timeout)
	else:
		if right_detect.is_colliding():
			disappear.stop()
			dir = 1
			minja.flip_h = false
			if not shooting and shoot.time_left == 0:
				shoot.start()
		if left_detect.is_colliding():
			disappear.stop()
			dir = -1
			minja.flip_h = true
			if not shooting and shoot.time_left == 0:
				shoot.start()
		if not right_detect.is_colliding() and not left_detect.is_colliding():
			if disappear.time_left == 0:
				disappear.start()
			
		if shooting:
			minja.play("throw")
		if not shooting and appeared:
			minja.play("idle")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

func _on_shoot_timeout() -> void:
	shooting = true
	shoot.stop()
	var new_star = star.instantiate()
	cooldown.start()
	add_child(new_star)

func _on_appear_timeout() -> void:
	appear.stop()
	rock.visible = false
	disguised = false
	appeared = true
	minja.animation_finished.disconnect(_on_appear_timeout)

func _on_cooldown_timeout() -> void:
	shooting = false
	cooldown.stop()

func disappear_func():
	minja.animation_finished.disconnect(disappear_func)
	minja.visible = false
	rock.visible = true

func _on_disappear_timeout() -> void:
	disappear.stop()
	appeared = false
	disguised = true
	minja.animation = "vanish"
	minja.animation_finished.connect(disappear_func)
