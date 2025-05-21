extends Control

var is_fullscreen := false
func _ready() -> void:
	$AnimationPlayer.play("RESET")
func resume() -> void:
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$AnimationPlayer.play_backwards("blur")
func pause() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
	$AnimationPlayer.play("blur")
func _input(event) -> void:
	if event.is_action_pressed("esc"):
		if get_tree().paused:
			resume()
		else:
			pause()
func _on_resume_pressed() -> void:
	resume()
func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()
func _on_exit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menu.tscn")
