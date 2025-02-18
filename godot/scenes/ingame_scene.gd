extends Node2D

@onready var fade_overlay = %FadeOverlay
@onready var pause_overlay = %PauseOverlay

func _ready() -> void:
	fade_overlay.visible = true
	
	if SaveGame.has_save():
		SaveGame.load_game(get_tree())
	
	pause_overlay.game_exited.connect(_save_game)

func _process(_delta: float) -> void:
	var intensidade = 1.0 - ($Timer.wait_time * 5/100)
	$GPUParticles2D.process_material.initial_velocity_min = intensidade*50
	$GPUParticles2D.process_material.spread = intensidade*45

func _input(event) -> void:
	if event.is_action_pressed("pause") and not pause_overlay.visible:
		get_viewport().set_input_as_handled()
		get_tree().paused = true
		pause_overlay.grab_button_focus()
		pause_overlay.visible = true
		
func _save_game() -> void:
	SaveGame.save_game(get_tree())

func _on_timer_timeout() -> void:
	print("Game Over")
