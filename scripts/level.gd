extends Node2D

var meteor_scene: PackedScene = load('res://scenes/meteor.tscn')
var laser_scene: PackedScene = load('res://scenes/laser.tscn')
var star_scene: PackedScene = load('res://scenes/star.tscn')
var shield_scene: PackedScene = load('res://scenes/shield.tscn')
var rapid_fire_scene: PackedScene = load("res://scenes/rapid_fire.tscn")

var rng = RandomNumberGenerator.new()

var min_shield_spawn_time := 5.0
var max_shield_spawn_time := 15.0

var min_rapid_fire_spawn_time := 9.00
var max_rapid_fire_spawn_time := 21.00

func _ready() -> void:
	get_tree().call_group('ui', 'set_health', Global.health)
	draw_stars()
	set_shield_timer()
	set_rapid_fire_timer()
	
func draw_stars():
	var size := get_viewport().get_visible_rect().size
	rng.randomize()
	for count in range(0, 35):
		var star = star_scene.instantiate()
		var random_x = rng.randi_range(0, int(size.x))
		var random_y = rng.randi_range(0, int(size.y))
		star.position = Vector2(random_x, random_y)
		$Stars.add_child(star)
		
		#var random_scale = rng.randf_range(0.6, 1.4)
		#star.get_child(0). = Vector2(random_scale, random_scale)
		#
		#star.speed
		
func set_shield_timer():
	rng.randomize()
	var shield_spawn_time = rng.randf_range(min_shield_spawn_time, max_shield_spawn_time)
	$Timers/ShieldTimer.wait_time = shield_spawn_time
	$Timers/ShieldTimer.start()
	

func set_rapid_fire_timer():
	rng.randomize()
	var rapid_fire_spawn_time = rng.randf_range(min_rapid_fire_spawn_time, max_rapid_fire_spawn_time)
	$Timers/RapidFireTimer.wait_time = rapid_fire_spawn_time
	$Timers/RapidFireTimer.start()


func _on_meteor_timer_timeout() -> void:
	var meteor = meteor_scene.instantiate()
	meteor.connect('collision', _on_meteor_collision)
	$Meteors.add_child(meteor)


func _on_meteor_collision():
	Global.health -= 1
	get_tree().call_group('ui', 'set_health', Global.health)
	if Global.health <= 0:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")


func _on_player_laser(pos) -> void:
	var laser = laser_scene.instantiate()
	laser.position = pos
	$Lasers.add_child(laser)
	

func _on_shield_timer_timeout() -> void:
	var shield = shield_scene.instantiate()
	$Powerups.add_child(shield)
	$Timers/ShieldTimer.stop()
	set_shield_timer()


func _on_rapid_fire_timer_timeout() -> void:
	var rapid_fire = rapid_fire_scene.instantiate()
	$Powerups.add_child(rapid_fire)
	$Timers/RapidFireTimer.stop()
	set_rapid_fire_timer()
