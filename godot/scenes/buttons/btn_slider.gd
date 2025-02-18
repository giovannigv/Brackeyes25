extends Node2D
var finish_event: bool = false

@onready var sprite_slider: Sprite2D = $Sprite2D/SpriteSlider

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		if(sprite_slider.position.y >= -55):
			sprite_slider.position.y -= 20
		else:
			finish_event = true
		print(sprite_slider.position.y)
