extends GameButton

@onready var sprite_button: Sprite2D = $Sprite2D/Sprite_Button
@onready var disp_wave: Node2D = $"../disp_wave"

signal finish_turn

var maxRot = 249
var gotRight = false

func _ready() -> void:
	disp_wave.finish_event.connect(gotRightWave)

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click") and !gotRight && Global.level == 5:
		if(sprite_button.rotation_degrees < 210 and sprite_button.rotation_degrees + 80 <= maxRot):
			sprite_button.rotation_degrees += 80
			disp_wave.changeWave()
		else:
			disp_wave.changeWave()
			sprite_button.rotation = maxRot

func gotRightWave():
	gotRight = true
	emit_signal("finish_turn")
	emiteSinal()
