extends GameButton
@onready var drawer_overlay: CenterContainer = %DrawerOverlay

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		sprite_2d.texture = ResourceLoader.load("res://art/drawer/drawer_open.png")
		drawer_overlay.visible = true
		get_viewport().set_input_as_handled()
		get_tree().paused = true


func _on_drawer_overlay_finish_event() -> void:
	drawer_overlay.visible = false
	get_tree().paused = false
