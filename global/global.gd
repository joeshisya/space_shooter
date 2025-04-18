extends Node

var max_health := 3
var health := 3
var play_time := 0
var meteors_destroyed := 0
var score := 0
var shoot_rate := 4 # Shots per second
var rapid_fire := false
var rapid_fire_count := 0

var is_shield_equiped := false


func activate_rapid_fire() -> void:
	rapid_fire_count += 1
	rapid_fire = true
	await get_tree().create_timer(10).timeout
	rapid_fire_count -= 1

	if rapid_fire_count <= 0:
		rapid_fire = false
		rapid_fire_count = 0  # safety net
