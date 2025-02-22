extends Node2D

@onready var timer_to_complete: Timer = $timer_to_complete
@onready var sprite_2d: Sprite2D = $Sprite2D

const fullTime = 10
const eachStep = 36 #degree for rotation
var moved = false
var finish_event = false

func activateTimer():
	timer_to_complete.start()
	
func _input(event):
	if event is InputEventMouseMotion:
		moved = true
	
func _process(_delta: float) -> void:
	if(moved):
		sprite_2d.rotation_degrees = 0
		timer_to_complete.start(fullTime)
		moved = false
	else:
		sprite_2d.rotation_degrees =  eachStep * timer_to_complete.time_left

func _on_timer_to_complete_timeout() -> void:
	finish_event = true
