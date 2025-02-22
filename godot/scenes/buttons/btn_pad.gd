extends GameButton

@warning_ignore("unused_signal")
signal pad_finished

@onready var btn_yellow3: TextureButton = $btn_yellow3
@onready var btn_orange3: TextureButton = $btn_orange3
@onready var btn_red: TextureButton = $btn_red
@onready var btn_pink3: TextureButton = $btn_pink3
@onready var btn_blue4: TextureButton = $btn_blue4

var enabled: bool = true
var index = 0
var finish_event = false

func _process(_delta: float) -> void:
	if index > 4 && enabled == true:
		enabled = false
		emit_signal("pad_finished")

func _on_area_2d_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	pass

func padControl(namePad: String):
	const array = ['btn_yellow3', 'btn_orange3', 'btn_red', 'btn_pink3', 'btn_blue4']

	#Lembrar q esse materi btn_active_mat é POC pra teste
	if(array[index] == namePad):
		index += 1
		print("Correct")
		showOrder(index)
	else:
		index = 0
		print("Wrong")

#ISSO É GAMBIARRA TIRAR DEPOIS DA NOVA SPRITE
func showOrder(indexLength):
	var arrayBtns = [btn_yellow3, btn_orange3, btn_red, btn_pink3, btn_blue4]
	var beforeIndex = -2
	var realIndex = indexLength + 1
	for i in realIndex:
		beforeIndex += 1
		if(beforeIndex >= 0):
			arrayBtns[beforeIndex].use_parent_material = true
		if(i < 5):
			#await get_tree().create_timer(0.2).timeout
			arrayBtns[i].use_parent_material = false
	
	
func _on_btn_yellow_button_up() -> void:
	padControl('btn_yellow')
	
func _on_btn_yellow_2_button_up() -> void:
	padControl('btn_yellow2')

func _on_btn_yellow_3_button_up() -> void:
	padControl('btn_yellow3')

func _on_btn_yellow_4_button_up() -> void:
	padControl('btn_yellow4')

func _on_btn_orange_button_up() -> void:
	padControl('btn_orange')

func _on_btn_orange_2_button_up() -> void:
	padControl('btn_orange2')

func _on_btn_orange_3_button_up() -> void:
	padControl('btn_orange3')

func _on_btn_orange_4_button_up() -> void:
	padControl('btn_orange4')

func _on_btn_red_button_up() -> void:
	padControl('btn_red')

func _on_btn_red_2_button_up() -> void:
	padControl('btn_red2')

func _on_btn_red_3_button_up() -> void:
	padControl('btn_red3')

func _on_btn_red_4_button_up() -> void:
	padControl('btn_red4')

func _on_btn_pink_button_up() -> void:
	padControl('btn_pink')

func _on_btn_pink_2_button_up() -> void:
	padControl('btn_pink2')

func _on_btn_pink_3_button_up() -> void:
	padControl('btn_pink3')

func _on_btn_pink_4_button_up() -> void:
	padControl('btn_pink4')

func _on_btn_blue_button_up() -> void:
	padControl('btn_blue')

func _on_btn_blue_2_button_up() -> void:
	padControl('btn_blue2')

func _on_btn_blue_3_button_up() -> void:
	padControl('btn_blue3')

func _on_btn_blue_4_button_up() -> void:
	padControl('btn_blue4')
