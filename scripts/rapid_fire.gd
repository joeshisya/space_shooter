extends Area2D

var speed: int


func _ready() -> void:
	var rng := RandomNumberGenerator.new()
	var width = get_viewport().get_visible_rect().size[0]
	var random_x = rng.randi_range(0, width)
	var random_y = rng.randi_range(-150, -50)
	position = Vector2(random_x, random_y)
	speed = rng.randi_range(250, 400)
	
	$Sprite2D.texture = load('res://graphics/powerups/lightning.png')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += Vector2(0.0, 1.0) * speed * delta


func _on_body_entered(body: Node2D) -> void:
	Global.activate_rapid_fire()
	$Sprite2D.hide()
	await get_tree().create_timer(10).timeout
