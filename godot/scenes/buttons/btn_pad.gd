extends GameButton

@warning_ignore("unused_signal")
signal pad_finished

@onready var btn_yellow3: TextureButton = $btn_yellow3
@onready var btn_red: TextureButton = $btn_red
@onready var btn_pink3: TextureButton = $btn_pink3
@onready var btn_blue4: TextureButton = $btn_blue4

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var enabled: bool = true
var index = 0
var finish_event = false
var pathArray: Array[String]

var yellowPath = "res://art/buttons/btn_pad_yellow.png"
var redPath = "res://art/buttons/btn_pad_red.png"
var pinkPath = "res://art/buttons/btn_pad_pink.png"
var bluePath = "res://art/buttons/btn_pad_blue.png"

func _ready() -> void:
	pathArray = [
		"res://art/buttons/btn_pad_red",
		"res://art/buttons/btn_pad_yellow", 
		"res://art/buttons/btn_pad_pink", 
		"res://art/buttons/btn_pad_blue"]

func _process(_delta: float) -> void:
	if index > 3 && enabled == true:
		enabled = false
		emit_signal("pad_finished")

func _on_area_2d_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	pass

func padControl(namePad: String):
	const array = [ 'btn_red', 'btn_yellow3','btn_pink3', 'btn_blue4']
	
	#Lembrar q esse materi btn_active_mat é POC pra teste
	if(array[index] == namePad):
		index += 1
		showOrder(index)
	else:
		index = 0
	audio_stream_player_2d.play()

#ISSO É GAMBIARRA TIRAR DEPOIS DA NOVA SPRITE
func showOrder(indexLength):
	var arrayBtns = [ btn_red, btn_yellow3, btn_pink3, btn_blue4]
	var beforeIndex = -2
	var realIndex = indexLength + 1
	for i in realIndex:
		beforeIndex += 1
		if(beforeIndex >= 0):
			var path = pathArray[beforeIndex] + ".png"
			var pathHover = pathArray[beforeIndex] + "_active_hover" + ".png"
			arrayBtns[beforeIndex].texture_normal = ResourceLoader.load(path)
			arrayBtns[beforeIndex].texture_hover = ResourceLoader.load(pathHover)
			#arrayBtns[beforeIndex].texture = ResourceLoader.load(arrayBtns[beforeIndex].texture)
		if(i < 4):
			#await get_tree().create_timer(0.2).timeout
			var path = pathArray[i] + "_active" + ".png"
			var pathHover = pathArray[i] + "_active_hover" + ".png"
			arrayBtns[i].texture_normal = ResourceLoader.load(path)
			arrayBtns[i].texture_hover = ResourceLoader.load(pathHover)
			#arrayBtns[i].use_parent_material = false
	
	texture_path.insert(sprite_2d.texture.get_path().length() - 4, "_hover")
	
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
