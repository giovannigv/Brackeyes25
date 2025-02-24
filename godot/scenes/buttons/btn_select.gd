extends GameButton

@warning_ignore("unused_signal")
signal picked_correct

@onready var btn_mini: TextureButton = $btn_mini
@onready var btn_mini_2: TextureButton = $btn_mini_2
@onready var btn_mini_3: TextureButton = $btn_mini_3
@onready var btn_mini_4: TextureButton = $btn_mini_4

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var buttons: Array[TextureButton]
var chosen: TextureButton
var button_dict = {
	"yellow": "btn_mini_2",
	"red": "btn_mini",
	"pink": "btn_mini_3",
	"blue": "btn_mini_4"
}

var mini_dict = {
	"btn_mini_2": "res://art/buttons/btn_mini2",
	"btn_mini": "res://art/buttons/btn_mini",
	"btn_mini_3": "res://art/buttons/btn_mini3",
	"btn_mini_4": "res://art/buttons/btn_mini4"
}

var started: bool = false

func _on_area_2d_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	pass
	
func _ready() -> void:
	buttons = [btn_mini, btn_mini_2, btn_mini_3, btn_mini_4]

func verifyButton(nameButton: String) -> void:
	audio_stream_player_2d.play()
	if started == true:
		if chosen.name == button_dict[nameButton]:
			emit_signal("picked_correct")
		else:
			chooseRandomButton()

func chooseRandomButton():
	if(chosen):
		chosen.texture_normal = ResourceLoader.load(mini_dict[chosen.name] + ".png")
	chosen = buttons.pick_random()
	chosen.texture_normal = ResourceLoader.load(mini_dict[chosen.name] + "_active.png")
	#chosen.use_parent_material = false

func _on_btn_yellow_button_up() -> void:
	verifyButton("yellow")

func _on_btn_red_button_up() -> void:
	verifyButton("red")

func _on_btn_pink_button_up() -> void:
	verifyButton("pink")

func _on_btn_blue_button_up() -> void:
	verifyButton("blue")
