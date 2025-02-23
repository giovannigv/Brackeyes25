extends GameButton

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click") and Global.level == 10 and Global.gotDisk:
		audio_player_2d.play()
		emiteSinal()
