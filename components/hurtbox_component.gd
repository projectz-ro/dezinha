class_name HurtBoxComponent
extends Area2D

@export var health_component: HealthComponent
@export var iframe_time: float = 2
@export var flicker_frequency: float = 0.1
@onready var flicker: Timer = $Flicker
@onready var i_frames: Timer = $IFrames

var invincible: bool = false

signal damage_taken(amount: int)

func _ready() -> void:
	i_frames.wait_time = iframe_time
	flicker.wait_time = flicker_frequency


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
		$"..".visible = !$"..".visible
		flicker.start()


func _on_i_frames_timeout() -> void:
	invincible = false
	$"..".visible = true
