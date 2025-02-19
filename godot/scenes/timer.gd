extends Timer
@onready var progress_bar: ProgressBar = $ProgressBar

func _process(_delta: float) -> void:
	progress_bar.value = time_left
