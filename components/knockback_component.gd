class_name KnockbackComponent
extends Node

## Uses move_and_slide()
@export var character: CharacterBody2D
## Describes the horizontal force of the knockback.
@export var force_x: int = 10
## Describes the vertical force of the knockback.
@export var force_y: int = 10
## How long the forces should be applied for.
@export var time: float = 0.2

@onready var duration: Timer = Timer.new()

var direction: int
var in_knockback: bool
var duration_over: bool

func _ready() -> void:
	duration.wait_time = time
	duration.connect("timeout", _on_duration_timeout)
	add_child(duration)

func _process(delta: float) -> void:
	if duration_over and character.is_on_floor():
		in_knockback = false

func _physics_process(delta: float) -> void:
	if in_knockback:
		character.velocity.x = force_x * -direction * delta
		character.velocity.y += -force_y * delta

# Provide facing direction
func start_knockback(dir: int):
	direction = dir
	duration_over = false
	duration.start()
	in_knockback = true

func _on_duration_timeout() -> void:
	duration.stop()
	duration_over = true
