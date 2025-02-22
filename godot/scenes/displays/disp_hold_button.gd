extends TextureProgressBar

@onready var hold_timer: Timer = %HoldTimer
const fullTime = 8
var isHolding = false
var wasHolding = false

signal finish_event

func holdingButton():
	isHolding = true

func releaseButton():
	isHolding = false
	

func _process(_delta: float) -> void:
	if(isHolding):
		if(wasHolding): 
			wasHolding = true
		else: #when is first time
			hold_timer.start()
			wasHolding = true
	else:
		wasHolding = false
		hold_timer.stop()
		hold_timer.wait_time = fullTime
	
	value = fullTime - hold_timer.time_left

func _on_hold_timer_timeout() -> void:
	finish_event.emit()
