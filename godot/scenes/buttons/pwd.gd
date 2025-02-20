extends GameButton

var number: int = 0

func _process(_delta: float) -> void:
	$Label.text = str(number)

	if pressed_this_level == true:
		pressed_this_level = false
		if number + 1 > 9:
			number = 0
		else:
			number += 1
