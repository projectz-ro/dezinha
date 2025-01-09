class_name MoveComponent
extends Node

enum Type{HORIZONTAL_PING_PONG, VERTICAL_PING_PONG, FORWARD}

@export var character: CharacterBody2D
@export var sprite: AnimatedSprite2D
@export var speed: float
@export var type: Type
@export var move_time: float
@export var pause_time: float
@export var use_gravity: bool
@export var turn_around: bool
@export var random_start: bool
@export var dir: int = 1

@onready var pause: Timer = Timer.new()
@onready var move: Timer = Timer.new()
@onready var r_start: Timer = Timer.new()

func _ready() -> void:
	add_child(move)
	add_child(pause)
	move.connect("timeout", _on_move_timeout)
	move.wait_time = move_time
	if not random_start:
		move.start()
	else:
		add_child(r_start)
		r_start.wait_time = randf_range(1, 3)
		r_start.connect("timeout", _on_r_start_timeout)
	pause.wait_time = pause_time
	pause.connect("timeout", _on_pause_timeout)

func _process(delta: float) -> void:
	if turn_around:
		if dir == 1: 
			sprite.flip_h = false
		else:
			sprite.flip_h = true

func _physics_process(delta: float) -> void:
	if use_gravity and not character.is_on_floor():
		character.velocity.y += character.get_gravity().y
	if not move.is_stopped():
		if type == Type.HORIZONTAL_PING_PONG or type == Type.FORWARD:
			character.velocity.x = dir * speed * delta
		character.move_and_slide()

func _on_pause_timeout() -> void:
	pause.stop()
	if turn_around:
		if dir == 1:
			dir = -1
		else:
			dir = 1
	move.start()


func _on_move_timeout() -> void:
	move.stop()
	pause.start()

func _on_r_start_timeout() -> void:
	move.start()
