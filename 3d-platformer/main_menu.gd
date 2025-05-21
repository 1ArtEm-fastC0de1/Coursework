extends Control

var button_type = null
var is_fullscreen := false
func _on_start_pressed() -> void:
	button_type = "start"
	$FadeTransition.show()
	$FadeTransition/fade_timer.start()
	$FadeTransition/AnimationPlayer.play("fade_in")
func _on_exit_pressed() -> void:
	get_tree().quit()
func _on_fade_timer_timeout() -> void:
	if button_type == "start":
		get_tree().change_scene_to_file("res://level_1.tscn")
func _on_fullscreen_button_pressed() -> void:
	is_fullscreen = !is_fullscreen
	if is_fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
func _on_music_button_pressed() -> void:
	if $MenuMusic.playing:
		$MenuMusic.stream_paused = true
		$offMusic.show()
	else:
		$MenuMusic.stream_paused = false
		$offMusic.hide()
