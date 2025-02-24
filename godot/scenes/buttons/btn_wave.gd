extends GameButton

var finish_event: bool = false

@onready var sprite_button: Sprite2D = $Sprite2D/Sprite_Button

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		if(!finish_event):
			if(sprite_button.rotation_degrees < 210):
				sprite_button.rotation_degrees += 30
			else:
				sprite_button.rotation = 249
				emiteSinal()
				
