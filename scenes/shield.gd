extends Area2D

var speed: int 
var is_equiped := false
var player: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rng := RandomNumberGenerator.new()
	var width = get_viewport().get_visible_rect().size[0]
	var random_x = rng.randi_range(0, width)
	var random_y = rng.randi_range(-150, -50)
	position = Vector2(random_x, random_y)
	speed = rng.randi_range(250, 400)
	
	$Sprite2D.texture = load('res://graphics/powerups/shield_1.png')
	
		
func _process(delta: float) -> void:
	position += Vector2(0.0, 1.0) * speed * delta
	
	if is_equiped:
		position = Vector2(player.position.x, player.position.y - 50)


func _on_body_entered(body: Node2D) -> void:
	if not Global.is_shield_equiped:
		speed = 0
		player = body
		position = Vector2(player.position.x, player.position.y -50)
		is_equiped = true
		Global.is_shield_equiped = true
		await get_tree().create_timer(5).timeout
		queue_free()
		Global.is_shield_equiped = false


func _on_area_entered(area: Area2D) -> void:
	if is_equiped:
		area.queue_free()
		Global.meteors_destroyed += 1
