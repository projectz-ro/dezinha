class_name HealthComponent
extends Node

@export var current_health: int
@export var max_health: int

signal health_changed(new_current: int, new_max: int)

# Increase max health and return the new max
func max_up(amount: int)-> int:
	max_health += amount
	health_changed.emit(current_health, max_health)
	return max_health

# Decrease max health and return the new max
func max_down(amount: int)-> int:
	max_health -= amount
	health_changed.emit(current_health, max_health)
	return max_health

# Add health from current health
func health_up(amount: int)-> int:
	current_health += amount
	health_changed.emit(current_health, max_health)
	return current_health

# Remove health from current health
func health_down(amount: int)-> int:
	current_health -= amount
	health_changed.emit(current_health, max_health)
	return current_health
