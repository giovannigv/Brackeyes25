extends TextureProgressBar

@onready var timer_to_complete: Timer = %timer_to_complete
const fullTime = 10
var moved = false
var finish_event = false

func activateTimer():
	timer_to_complete.start()
	
func _input(event):
	if event is InputEventMouseMotion:
		moved = true
	
func _process(delta: float) -> void:
	if(moved):
		value = fullTime
		timer_to_complete.start(fullTime)
		moved = false
	else:
		value = timer_to_complete.time_left

func _on_timer_to_complete_timeout() -> void:
	finish_event = true
