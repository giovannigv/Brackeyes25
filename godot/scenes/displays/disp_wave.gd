extends Node2D

@onready var disp_first_wave: Sprite2D = $DispFirstWave
@onready var disp_sec_wave: Sprite2D = $DispSecWave
@onready var disp_third_wave: Sprite2D = $DispThirdWave
@onready var disp_four_wave: Sprite2D = $DispFourWave

signal finish_event

var waves: Array[Sprite2D]
var index = 1
var randomChose = randi_range(1,3)

func _ready() -> void:
	waves = [disp_first_wave, disp_sec_wave, disp_third_wave, disp_four_wave]
# So serve para a primeira vez q liga ele, precisa ter pra segunda
func changeWave():
	if(index > 2):
		index = 0
		waves[3].set_visible(false)
		waves[index].set_visible(true)
	else:
		if(index == 0):
			waves[3].set_visible(false)
			waves[index].set_visible(true)
		else:
			waves[index].set_visible(true)
			waves[index-1].set_visible(false)
			index += 1
	if(index == randomChose):
		finish_event.emit()

func restart():
	index = 0
	randomChose = randi_range(1,3)
	disp_first_wave.set_visible(true)
	disp_sec_wave.set_visible(false)
	disp_third_wave.set_visible(false)
	disp_four_wave.set_visible(false)
