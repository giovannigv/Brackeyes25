extends Timer
@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar

var maxTimer = 60

func _process(_delta: float) -> void:
	texture_progress_bar.value = maxTimer - time_left
