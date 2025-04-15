extends Control

@export var level_scene: PackedScene = load("res://scenes/level.tscn")


func _ready() -> void:
	$CenterContainer/VBoxContainer/TimeLabel.text = $CenterContainer/VBoxContainer/TimeLabel.text + str(Global.play_time) + " seconds"
	$CenterContainer/VBoxContainer/MeteorLabel.text = $CenterContainer/VBoxContainer/MeteorLabel.text + str(Global.meteors_destroyed)
	$CenterContainer/VBoxContainer/ScoreLabel.text = $CenterContainer/VBoxContainer/ScoreLabel.text + str(Global.score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		get_tree().change_scene_to_packed(level_scene)
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
			get_tree().change_scene_to_packed(level_scene)
		
