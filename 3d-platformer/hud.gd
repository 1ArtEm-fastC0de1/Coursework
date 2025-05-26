extends CanvasLayer

@onready var timer_label : Label = $TimerLabel
@onready var timer : Timer = $Timer
var time_left := 60.0

func _ready() -> void:
	Global.current_level_path = get_tree().current_scene.scene_file_path
	Global.coins_count = 0
	timer.wait_time = 0.05 
	timer.one_shot = false
	timer.autostart = true
	timer.start()
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	update_timer_display()

func _on_timer_timeout() -> void:
	time_left = max(time_left - timer.wait_time, 0)
	Global.time_left = time_left
	if time_left <= 0:
		timer.stop()
		get_tree().change_scene_to_file("res://game_over_dialog.tscn")
	update_timer_display()

func update_timer_display() -> void:
	var total_ms = int(time_left * 1000)
	var seconds = total_ms / 1000
	var milliseconds = total_ms % 1000
	timer_label.text = "%02d:%03d" % [seconds, milliseconds]
