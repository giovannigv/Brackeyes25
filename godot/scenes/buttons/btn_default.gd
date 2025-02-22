extends GameButton

var finish_event: bool = false

@onready var sprite_btn_default: Sprite2D = $Sprite2D

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		sprite_btn_default.texture = ResourceLoader.load("res://art/buttons/btn_default_on.jpg")
		emiteSinal()
	if event.is_action_released("click"):
		sprite_btn_default.texture = ResourceLoader.load("res://art/buttons/btn_default_off.jpg")
