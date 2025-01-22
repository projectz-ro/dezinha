class_name HurtBoxComponent
extends Area2D

@export var root: Node2D
@export var health_component: HealthComponent
@export var knockback: KnockbackComponent
@export var iframe_time: float = 2
@export var flicker_frequency: float = 0.1
@onready var flicker: Timer = Timer.new()
@onready var i_frames: Timer = Timer.new()

var invincible: bool = false

signal damage_taken(amount: int)

func _ready() -> void:
	add_child(flicker)
	add_child(i_frames)
	i_frames.wait_time = iframe_time
	flicker.wait_time = flicker_frequency
	i_frames.connect("timeout", _on_i_frames_timeout)
	flicker.connect("timeout", _on_flicker_timeout)
	self.connect("area_entered", _on_area_entered)

func recieve_damage(amount: int)-> void:
	damage_taken.emit(amount)
	health_component.health_down(amount)

func start_iframes():
	i_frames.start()
	flicker.start()
	invincible = true

func _on_flicker_timeout() -> void:
	if invincible:
		flicker.stop()
		root.visible = !root.visible
		flicker.start()

func _on_i_frames_timeout() -> void:
	invincible = false
	root.visible = true

func _on_area_entered(area: Area2D) -> void:
	if area is HitBoxComponent and not invincible:
		recieve_damage(area.damage_amount)
		start_iframes()
			
		if knockback != null:
			if global_position.direction_to(area.global_position).x > 0:
				knockback.start_knockback(1)
			else:
				knockback.start_knockback(-1)
