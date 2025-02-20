extends GameButton

var number: int = 0

func _process(_delta: float) -> void:
	$Label.text = str(number)
