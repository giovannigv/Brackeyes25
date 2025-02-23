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

func changeWave():
	match index:
		0: 
			waves[0].set_visible(true)
			waves[3].set_visible(false)
		1:
			waves[1].set_visible(true)
			waves[0].set_visible(false)
		2:
			waves[2].set_visible(true)
			waves[1].set_visible(false)
		3:
			waves[3].set_visible(true)
			waves[2].set_visible(false)
	if(index == randomChose):
		finish_event.emit()
	else:
		index += 1

#Usar apenas se tiver uma segunda tentativa
#func restart():
	#index = 0
	#randomChose = randi_range(1,3)
	#disp_first_wave.set_visible(true)
	#disp_sec_wave.set_visible(false)
	#disp_third_wave.set_visible(false)
	#disp_four_wave.set_visible(false)
