extends Area3D

const ROT_SPEED_COIN := 3
@export var hud : CanvasLayer


func _process(delta: float) -> void:
	rotate_y(ROT_SPEED_COIN*delta)

func _on_body_entered(body: Node3D) -> void:
	$GetCoinSound.play()
	Global.coins_count += 1
	hud.get_node("CoinsLabel").text = str(Global.coins_count)
	if Global.coins_count >= Global.max_num_coin:
		get_tree().change_scene_to_file("res://game_win_dialog.tscn")
		
	$AnimationPlayer.play("dissolution")
	set_collision_layer_value(3,false)
	set_collision_mask_value(1,false)
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()

	
