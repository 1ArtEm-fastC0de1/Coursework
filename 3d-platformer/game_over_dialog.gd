extends CanvasLayer

func _ready() -> void:
	$GameOverSound.play()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_restart_pressed() -> void:
	if Global.current_level_path != "":
		get_tree().change_scene_to_file(Global.current_level_path)
		
func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
