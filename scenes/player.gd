extends CharacterBody2D

const SPEED = 50.0
const JUMP_VELOCITY = -100.0
const GRAVITY = 400

var direction: float = 0
var invincible = false
var phoneMode = false
var shooting = false
var jump_count = 0
var max_jumps = 2
var knockback = 60
var knockback_done = true
var in_knockback = false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var phone: AnimatedSprite2D = $Phone
@onready var flash_timer: Timer = $Phone/FlashTimer
@onready var phone_flash: Sprite2D = $Phone/Flash
@onready var shutter_sound: AudioStreamPlayer = $Phone/ShutterSound

func _process(delta: float) -> void:
	phone.visible = phoneMode
	if is_on_floor():
		if abs(velocity.x) > 0:
			sprite.animation = "run"
		else: 
			sprite.animation = "idle"
			
		if Input.is_action_just_pressed("interact"):
			if phoneMode:
				shooting = true
				flash_timer.start()
				shutter_sound.play()
				if not Input.is_action_pressed("down"):
					phone_flash.visible = true
				phone.play("screen flash")
			sprite.animation = "interact"
			
		if Input.is_action_just_pressed("phone"):
			phoneMode = !phoneMode
			phone.visible = phoneMode
			if not phoneMode:
				phone_flash.visible = false
				phone.animation = "default"
			
		if phoneMode:
			sprite.animation = "interact"
	else:
		sprite.animation = "air"

func _physics_process(delta: float) -> void:
	direction = Input.get_axis("left", "right")
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		
	if Input.is_action_just_pressed("jump"):
		jump()
	if knockback_done and is_on_floor():
		in_knockback = false
	if not in_knockback:
		if direction:
			phoneMode = false
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
		if direction < 0:
			sprite.flip_h = true
			phone.flip_h = true
			phone_flash.flip_h = true
			phone_flash.offset.x = -16
		elif direction > 0:
			sprite.flip_h = false
			phone.flip_h = false
			phone_flash.flip_h = false
			phone_flash.offset.x = 16
	
	if not phoneMode:
		move_and_slide()

func jump() -> void:
	if is_on_floor():
		jump_count = 0
	 
	if jump_count < max_jumps:
		jump_count += 1  
		velocity.y = JUMP_VELOCITY

func _on_flash_timer_timeout() -> void:
	phone.play("default")
	phone_flash.visible = false
	shooting = false

func _on_hitbox_body_entered(body: Node2D) -> void:
	if not invincible:
		GameManager.add_health(-1)
		invincible = true
		in_knockback = true
		knockback_done = false
		$Hitbox/IFrames.start()
		$Hitbox/Flicker.start()
		$Hitbox/Knockback.start()
		var dir = 1
		if sprite.flip_h:
			dir = -1
		else:
			dir = 1
		velocity.x = -dir * knockback
		velocity.y = -knockback

func _on_flicker_timeout() -> void:
	if invincible:
		$Hitbox/Flicker.start()
		sprite.visible = !sprite.visible


func _on_i_frames_timeout() -> void:
	invincible = false
	sprite.visible = true


func _on_knockback_timeout() -> void:
	knockback_done = true
