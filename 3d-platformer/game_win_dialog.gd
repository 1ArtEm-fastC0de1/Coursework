extends CanvasLayer


func _ready() -> void:
	$CoinLabel.text = "Coins collected: %d" % Global.coins_count
	$TimeLabel.text = "Remaining time: %.2f" % Global.time_left
	$GameWinSound.play()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_next_level_pressed() -> void:
	Global.goto_next_level()

func _on_restart_pressed() -> void:
	if Global.current_level_path != "":
		get_tree().change_scene_to_file(Global.current_level_path)

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
