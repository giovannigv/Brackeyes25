extends GameButton

@onready var sprite_hold: Sprite2D = $Sprite2D
@onready var disp_hold_button: TextureProgressBar = $"../DispHoldButton"
@onready var disp_hold_button_2: TextureProgressBar = $"../DispHoldButton2"
@onready var disp_hold_button_3: TextureProgressBar = $"../DispHoldButton3"
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if Global.level == 6:
		if event.is_action_pressed("click"):
			audio_stream_player_2d.play()
			sprite_hold.texture = ResourceLoader.load("res://art/buttons/btn_default_on.png")
			disp_hold_button.holdingButton()
			disp_hold_button_2.holdingButton()
			disp_hold_button_3.holdingButton()
			
		if event.is_action_released("click"):
			audio_stream_player_2d.play()
			sprite_hold.texture = ResourceLoader.load("res://art/buttons/btn_default_off.png")
			disp_hold_button.releaseButton()
			disp_hold_button_2.releaseButton()
			disp_hold_button_3.releaseButton()

func finish_event():
	emiteSinal()


func _on_disp_hold_button_finish_event() -> void:
	finish_event()
