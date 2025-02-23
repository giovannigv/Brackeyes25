extends GameButton

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click") and Global.level == 10:
		sprite_2d.texture = ResourceLoader.load("res://art/buttons/btn_emergency_press.png")
		audio_player_2d.play()

	if event.is_action_released("click") and Global.level == 10:
		sprite_2d.texture = ResourceLoader.load("res://art/buttons/btn_emergency.png")

func bothPressed():
	emiteSinal()
