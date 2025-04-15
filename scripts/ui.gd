extends CanvasLayer

static var image = load('res://graphics/lives/Player Life.png')
var time_elapsed := 0


func set_health(amount):
	for child in $MarginContainer2/HBoxContainer.get_children():
		child.queue_free()
	
	for i in amount:
		var text_rect = TextureRect.new()
		text_rect.texture = image
		text_rect.stretch_mode = TextureRect.STRETCH_KEEP
		$MarginContainer2/HBoxContainer.add_child(text_rect)


func _on_score_timer_timeout() -> void:
	time_elapsed += 1
	Global.score += 1
	$MarginContainer/Label.text = str(Global.score)
