extends Node2D

@onready var disp_first_wave: Sprite2D = $DispFirstWave
@onready var disp_sec_wave: Sprite2D = $DispSecWave
@onready var disp_third_wave: Sprite2D = $DispThirdWave
@onready var disp_four_wave: Sprite2D = $DispFourWave

var waves = [disp_first_wave, disp_sec_wave, disp_third_wave, disp_four_wave]
var index = 0

func changeWave():
	if(index > 3):
		index = 0
		waves[4].visible = false
		waves[index].visible = true
	else:
		if(index == 0):
			waves[4].visible = false
			waves[index].visible = true
		else:
			waves[index].visible = true
			waves[index-1].visible = false
			index += 1
