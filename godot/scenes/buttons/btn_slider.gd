extends Node2D
var finish_event: bool = false

@onready var sprite_slider: Sprite2D = $Sprite2D/SpriteSlider
@onready var disp_measurer: Node2D = $"../disp_measurer"
@onready var broken_disp_measurer: Node2D = $"../disp_measurer2"

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		if(sprite_slider.position.y >= -55):
			sprite_slider.position.y -= 20
			disp_measurer.update_rating(30) #Is for 6x to reach 180 degree
			broken_disp_measurer.update_rating(22)
		else:
			finish_event = true
		print(sprite_slider.position.y)
