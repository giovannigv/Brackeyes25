extends Timer
@onready var progress_bar: ProgressBar = $ProgressBar

func _process(delta: float) -> void:
	progress_bar.value = time_left
