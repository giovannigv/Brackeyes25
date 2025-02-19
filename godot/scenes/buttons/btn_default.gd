extends GameButton

var finish_event: bool = false

@onready var sprite_2d: Sprite2D = $Sprite2D

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		sprite_2d.texture = ResourceLoader.load("res://art/buttons/btn_default_on.jpg")
		finish_event = !finish_event
