extends Timer
@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar

var max = 60

func _process(_delta: float) -> void:
	texture_progress_bar.value = max - time_left
