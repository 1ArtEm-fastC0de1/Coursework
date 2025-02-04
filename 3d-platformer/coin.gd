extends Area3D

const ROT_SPEED_COIN = 3

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	rotate_y(ROT_SPEED_COIN*delta)

func _on_body_entered(body: Node3D) -> void:
	Global.coins_count += 1
	if Global.coins_count >= Global.MAX_NUM_COIN:
		get_tree().change_scene_to_file("res://level_1.tscn")
	$AnimationPlayer.play("dissolution")
	set_collision_layer_value(3,false)
	set_collision_mask_value(1,false)
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
	
