extends Area2D

var speed: int
var rotation_speed: float
var direction: float
var can_collide := true
signal collision
var meteor_textures = [
	"res://graphics/meteors/Meteor Big.png",
	"res://graphics/meteors/meteorBrown_big1.png",
	"res://graphics/meteors/meteorBrown_big2.png",
	"res://graphics/meteors/meteorBrown_big3.png",
	"res://graphics/meteors/meteorBrown_big4.png",
	"res://graphics/meteors/meteorGrey_big1.png",
	"res://graphics/meteors/meteorGrey_big3.png",
	"res://graphics/meteors/meteorGrey_big4.png"
]

func _ready() -> void:
	var rng := RandomNumberGenerator.new()
	var width = get_viewport().get_visible_rect().size[0]
	var random_x = rng.randi_range(0, width)
	var random_y = rng.randi_range(-150, -50)
	position = Vector2(random_x, random_y)
	
	$Sprite2D.texture = load(meteor_textures.pick_random())
	
	speed = rng.randi_range(250, 400)
	rotation_speed = rng.randf_range(40, 100)
	direction = rng.randf_range(-0.5, 0.5)
	
		
func _process(delta: float) -> void:
	position += Vector2(direction, 1.0) * speed * delta
	rotation_degrees += rotation_speed * delta


func _on_body_entered(_body: Node2D) -> void:
	if can_collide:
		collision.emit()


func _on_area_entered(area: Area2D) -> void:
	area.queue_free()
	$explosion_sound.play()
	$Sprite2D.hide()
	can_collide = false
	await get_tree().create_timer(1).timeout
	queue_free()
	Global.meteors_destroyed += 1
	Global.score += 2
