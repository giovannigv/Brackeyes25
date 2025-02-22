extends GameButton

@onready var key_draggable: Node2D = $"../KeyDraggable"

func turnOn():
	emiteSinal()

func _ready() -> void:
	key_draggable.turnPCOn.connect(turnOn)
	pass

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	pass

func _on_area_2d_mouse_entered() -> void:
	pass

func _on_area_2d_mouse_exited() -> void:
	pass
	
