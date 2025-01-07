extends CharacterBody2D

const SPEED = 2000.0
const JUMP_VELOCITY = -100.0
const GRAVITY = 400

var direction: float = 0

var phoneMode = false
var shooting = false

var jump_count = 0
var max_jumps = 2

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var phone: AnimatedSprite2D = $Phone
@onready var phone_flash: Sprite2D = $Phone/Flash
@onready var flash_hitbox: CollisionShape2D = $Phone/Flash/HitboxComponent/CollisionShape2D
@onready var flash_timer: Timer = $Phone/FlashTimer
@onready var shutter_sound: AudioStreamPlayer = $Phone/ShutterSound

func _ready() -> void:
	flash_hitbox.set_deferred("disabled", true)
	phone_flash.visible = false

func _process(delta: float) -> void:
	phone.visible = phoneMode
	if is_on_floor() and not $KnockbackComponent.in_knockback:
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
					flash_hitbox.set_deferred("disabled", false)
				phone.play("screen flash")
			sprite.animation = "interact"
			
		if Input.is_action_just_pressed("phone"):
			phoneMode = !phoneMode
			phone.visible = phoneMode
			if not phoneMode:
				phone_flash.visible = false
				flash_hitbox.set_deferred("disabled", true)
				phone.animation = "default"
			
		if phoneMode:
			sprite.animation = "interact"
	else:
		sprite.animation = "air"

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	if Input.is_action_just_pressed("jump"):
		jump()
	
	if not $KnockbackComponent.in_knockback:
		direction = roundi(Input.get_axis("left", "right"))
		if direction:
			phoneMode = false
			velocity.x = direction * SPEED * delta
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
		if direction < 0:
			sprite.flip_h = true
			phone.flip_h = true
			phone_flash.flip_h = true
			phone_flash.offset.x = -16
			$Phone/Flash/HitboxComponent.scale.x = -1
		elif direction > 0:
			sprite.flip_h = false
			phone.flip_h = false
			phone_flash.flip_h = false
			phone_flash.offset.x = 16
			$Phone/Flash/HitboxComponent.scale.x = 1
	else:
		sprite.animation = "hurt"
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
	flash_hitbox.set_deferred("disabled", true)
	phone_flash.visible = false
	shooting = false

func _on_hurtbox_component_area_entered(area: Area2D) -> void:
	if not $HurtboxComponent.invincible:
		phoneMode = false
		$HurtboxComponent.recieve_damage(1)
		$HurtboxComponent.start_iframes()
		var dir: int
		if sprite.flip_h:
			dir = -1
		else:
			dir = 1
		$KnockbackComponent.start_knockback(dir)
