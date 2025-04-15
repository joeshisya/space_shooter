extends CanvasLayer

static var image = load('res://graphics/lives/Player Life.png')


func set_health(amount):
	for child in $MarginContainer2/HBoxContainer.get_children():
		child.queue_free()
	
	for i in amount:
		var text_rect = TextureRect.new()
		text_rect.texture = image
		text_rect.stretch_mode = TextureRect.STRETCH_KEEP
		$MarginContainer2/HBoxContainer.add_child(text_rect)


func _on_score_timer_timeout() -> void:
	Global.play_time += 1
	Global.score += 1
	$MarginContainer/HBoxContainer/PlayTimeLabel.text = "Play Time: " + str(Global.play_time) + " Seconds"
	$MarginContainer/HBoxContainer/MeteorsLabel.text = "Meteors Destroyed: " + str(Global.meteors_destroyed)
	$MarginContainer/HBoxContainer/ScoreLabel.text = "Score: " + str(Global.score)
