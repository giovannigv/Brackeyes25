extends CenterContainer

signal game_exited

@onready var settings_button := %SettingsButton
@onready var restart_button: Button = %RestartButton
@onready var settings_container := %SettingsContainer
@onready var menu_container := %MenuContainer
@onready var back_button := %BackButton

func _ready() -> void:
	restart_button.pressed.connect(_restart)
	settings_button.pressed.connect(_settings)
	back_button.pressed.connect(_pause_menu)
	_resume()
	
func grab_button_focus() -> void:
	restart_button.grab_focus()
	
func _resume() -> void:
	get_tree().paused = false
	visible = false
	
	
func _settings() -> void:
	menu_container.visible = false
	settings_container.visible = true
	back_button.grab_focus()
	
func _pause_menu() -> void:
	settings_container.visible = false
	menu_container.visible = true
	settings_button.grab_focus()

func _restart() -> void:
	get_tree().reload_current_scene()
	_resume()

func _unhandled_input(event):
	if event.is_action_pressed("pause") and visible:
		get_viewport().set_input_as_handled()
		if menu_container.visible:
			_resume()
		if settings_container.visible:
			_pause_menu()
