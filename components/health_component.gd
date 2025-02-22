class_name HealthComponent
extends Node

@export var max_health: int = 2
@export var current_health: int = 2

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
	if current_health > max_health:
		current_health = max_health
	health_changed.emit(current_health, max_health)
	return current_health

# Remove health from current health
func health_down(amount: int)-> int:
	current_health -= amount
	if current_health < 0:
		current_health = 0
	health_changed.emit(current_health, max_health)
	return current_health
