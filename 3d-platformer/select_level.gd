extends Control

func _ready() -> void:
	for i in range(1, 6): 
		var button = $VBoxContainer.get_node(str(i))
		button.pressed.connect(_on_level_button_pressed.bind(i - 1)) 

func _on_level_button_pressed(index: int) -> void:
	Global.level_index = index
	Global.current_level_path = Global.level_paths[index]
	get_tree().change_scene_to_file(Global.current_level_path)

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
