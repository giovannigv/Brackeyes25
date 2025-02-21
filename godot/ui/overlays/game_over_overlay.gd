extends CenterContainer

@warning_ignore("unused_signal")
signal game_exited

@onready var restart_button: Button = %RestartButton_GO
@onready var exit_button: Button = %ExitButton_GO
@onready var menu_container: VBoxContainer = %MenuContaine_GO


func _ready() -> void:
	exit_button.pressed.connect(_exit)
	#_resume()
	
func grab_button_focus() -> void:
	restart_button.grab_focus()
	
func _resume() -> void:
	print("called")
	get_tree().paused = false
	visible = false

func _exit() -> void:
	game_exited.emit()
	get_tree().quit()

func _on_restart_button_go_button_down() -> void:
	print("Restart")
	get_tree().paused = false
	visible = false
	get_tree().reload_current_scene()
