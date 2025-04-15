extends CharacterBody2D

@export var SPEED: int = 500
var can_shoot: bool = true
signal laser(pos)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(1280/2, 720 - 75)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED
	move_and_slide()

	if Input.is_action_just_pressed("shoot") && can_shoot:
		laser.emit($LaserStartPos.global_position)
		can_shoot = false
		$LaserTimer.start()
		$laser_sound.play()
		
		
func _on_laser_timer_timeout() -> void:
	can_shoot = true
