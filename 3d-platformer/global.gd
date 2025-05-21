extends Node

var current_level_path: String = ""
var coins_count := 0
var max_num_coin := 0
var level_index := 0
var level_paths := [
	"res://level_1.tscn",
	"res://level_2.tscn",
	"res://level_3.tscn",
	"res://level_4.tscn",
	"res://level_5.tscn"
]

func goto_next_level() -> void:
	level_index += 1
	if level_index >= level_paths.size():
		level_index = 0
	get_tree().change_scene_to_file(level_paths[level_index])
