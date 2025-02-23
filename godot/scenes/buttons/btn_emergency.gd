extends GameButton
var isPressing = false

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		sprite_2d.texture = ResourceLoader.load("res://art/buttons/btn_emergency_press.png")
		audio_player_2d.play()
		verifyOtherIsPressing()

	if event.is_action_released("click"):
		sprite_2d.texture = ResourceLoader.load("res://art/buttons/btn_emergency.png")

func verifyOtherIsPressing():
	if (name == "Big F Button 2"):
		if($"../Big F Button 1".isPressing == true):
			bothPressed()
	if (name == "Big F Button 1"):
		if($"../Big F Button 2".isPressing == true):
			bothPressed()
			
func bothPressed():
	emiteSinal()
