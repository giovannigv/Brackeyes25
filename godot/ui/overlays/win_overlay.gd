extends CenterContainer

@onready var exit_button := %ExitButton
@onready var menu_container := %MenuContainer

func _ready() -> void:
	exit_button.pressed.connect(_exit)
	
func grab_button_focus() -> void:
	exit_button.grab_focus()
	
func _resume() -> void:
	get_tree().paused = false
	visible = false
	
func _exit() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu_scene.tscn")
	
