extends GameButton

@warning_ignore("unused_signal")
signal slider_max

@onready var disp_measurer: Node2D = $"../disp_measurer"
@onready var broken_disp_measurer: Node2D = $"../disp_measurer2"
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click") and Global.level >= 1:
		if(sprite_2d.position.y >= -55):
			sprite_2d.position.y -= 20
			disp_measurer.update_rating(30) #Is for 6x to reach 180 degree
			broken_disp_measurer.update_rating(22)
		else:
			sprite_2d.position.y = 64
		if sprite_2d.position.y == -56:
			emit_signal("slider_max")
