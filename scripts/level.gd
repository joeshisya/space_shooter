extends Node2D

var meteor_scene: PackedScene = load('res://scenes/meteor.tscn');
var laser_scene: PackedScene = load('res://scenes/laser.tscn');
var star_scene: PackedScene = load('res://scenes/star.tscn')

var health: int = 3


func _ready() -> void:
	get_tree().call_group('ui', 'set_health', health)
	draw_stars()


func _on_meteor_timer_timeout() -> void:
	var meteor = meteor_scene.instantiate()
	meteor.connect('collision', _on_meteor_collision)
	$Meteors.add_child(meteor)


func _on_meteor_collision():
	health -= 1
	get_tree().call_group('ui', 'set_health', health)
	if health <= 0:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")


func _on_player_laser(pos) -> void:
	var laser = laser_scene.instantiate()
	$Lasers.add_child(laser)
	laser.position = pos
	
	
func draw_stars():
	var size := get_viewport().get_visible_rect().size
	var rng = RandomNumberGenerator.new()
	for count in range(0, 35):
		var star = star_scene.instantiate()
		var random_x = rng.randi_range(0, size.x)
		var random_y = rng.randi_range(0, size.y)
		$Stars.add_child(star)
		star.position = Vector2(random_x, random_y)
		
		#var random_scale = rng.randf_range(0.6, 1.4)
		#star.get_child(0). = Vector2(random_scale, random_scale)
		#
		#star.speed
