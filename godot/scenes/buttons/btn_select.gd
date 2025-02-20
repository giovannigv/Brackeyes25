extends GameButton

@onready var btn_mini: TextureButton = $btn_mini
@onready var btn_mini_2: TextureButton = $btn_mini_2
@onready var btn_mini_3: TextureButton = $btn_mini_3
@onready var btn_mini_4: TextureButton = $btn_mini_4
@onready var btn_mini_5: TextureButton = $btn_mini_5

var buttons: Array[TextureButton]
var chosen: TextureButton
var finish_event = false
var button_dict = {
	"yellow": "btn_mini",
	"orange": "btn_mini_2",
	"red": "btn_mini_3",
	"pink": "btn_mini_4",
	"blue": "btn_mini_5"
}

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	pass
	
func _ready() -> void:
	buttons = [btn_mini, btn_mini_2, btn_mini_3, btn_mini_4, btn_mini_5]
	chooseRandomButton()

func verifyButton(nameButton: String) -> void:
	if(chosen.name == button_dict[nameButton]):
		print("Correct")
		finish_event = true
	else:
		print("Wrong")
		chooseRandomButton()

func chooseRandomButton():
	if(chosen):
		chosen.use_parent_material = true
	chosen = buttons.pick_random()
	chosen.use_parent_material = false

func _on_btn_yellow_button_up() -> void:
	verifyButton("yellow")

func _on_btn_orange_button_up() -> void:
	verifyButton("orange")

func _on_btn_red_button_up() -> void:
	verifyButton("red")

func _on_btn_pink_button_up() -> void:
	verifyButton("pink")

func _on_btn_blue_button_up() -> void:
	verifyButton("blue")
