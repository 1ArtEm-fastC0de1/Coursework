extends Node3D

func _ready() -> void:
	Global.level_index = 2
	$fadeTransition/AnimationPlayer.play("fade_out")
	Global.coins_count = 0
	Global.current_level_path = get_scene_file_path()
	Global.max_num_coin = 19
