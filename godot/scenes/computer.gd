extends GameButton

@warning_ignore("unused_signal")
signal pc_on

@onready var key_draggable: Node2D = $"../KeyDraggable"
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func turnOn():
	audio_stream_player_2d.play()
	emiteSinal()
	emit_signal("pc_on")

func _ready() -> void:
	key_draggable.turnPCOn.connect(turnOn)

func _on_area_2d_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	pass

func _on_area_2d_mouse_entered() -> void:
	pass

func _on_area_2d_mouse_exited() -> void:
	pass
	
