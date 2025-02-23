extends GameButton

@onready var disp_wave: Node2D = $"../disp_wave"

@warning_ignore("unused_signal")
signal finish_turn

const Pos1 = preload("res://art/buttons/btn_disk_1.png")
const Pos2 = preload("res://art/buttons/btn_disk_2.png")
const Pos3 = preload("res://art/buttons/btn_disk_3.png")
const Pos4 = preload("res://art/buttons/btn_disk_4.png")

var maxRot = 249
var index = 1
var gotRight = false

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click") and !gotRight && (Global.level == 5 || Global.level == 7):
		if(index > 3):
			index = 0
		match index:
			0: sprite_2d.texture = Pos1
			1: sprite_2d.texture = Pos2
			2: sprite_2d.texture = Pos3
			3: sprite_2d.texture = Pos4
		index += 1
		disp_wave.changeWave()

func gotRightWave():
	print("WAVE")
	gotRight = true
	emit_signal("finish_turn")
	emiteSinal()


func _on_disp_wave_finish_event() -> void:
	gotRightWave()
