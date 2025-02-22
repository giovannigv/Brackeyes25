extends GameButton

@onready var sprite_hold: Sprite2D = $Sprite2D
@onready var disp_hold_button: TextureProgressBar = $"../DispHoldButton"

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if Global.level == 6:
		if event.is_action_pressed("click"):
			sprite_hold.texture = ResourceLoader.load("res://art/buttons/btn_default_on.jpg")
			disp_hold_button.holdingButton()
			
		if event.is_action_released("click"):
			sprite_hold.texture = ResourceLoader.load("res://art/buttons/btn_default_off.jpg")
			disp_hold_button.releaseButton()

func _ready() -> void:
	disp_hold_button.finish_event.connect(finish_event)
	
func finish_event():
	emiteSinal()
