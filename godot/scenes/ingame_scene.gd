extends Node2D

@onready var fade_overlay = %FadeOverlay
@onready var pause_overlay = %PauseOverlay

func _ready() -> void:
	fade_overlay.visible = true
	
	if SaveGame.has_save():
		SaveGame.load_game(get_tree())
	
	pause_overlay.game_exited.connect(_save_game)

func _process(_delta: float) -> void:
	#Sistema de gerenciamento do estabilidade
	var intensidade = 1.0 - ($Timer.time_left * 5/100)
	$GPUParticles2D.process_material.initial_velocity_min = intensidade*50
	$GPUParticles2D.process_material.spread = intensidade*45
	$GPUParticles2D.set_self_modulate(Color(get_self_modulate().r - intensidade, get_self_modulate().g, get_self_modulate().b - intensidade))
	$GPUParticles2D.process_material.scale_min = lerp(0.5, 2.5, intensidade)
	$GPUParticles2D.process_material.scale_max = lerp(1.0, 3.0, intensidade)

func _input(event) -> void:
	if event.is_action_pressed("pause") and not pause_overlay.visible:
		get_viewport().set_input_as_handled()
		get_tree().paused = true
		pause_overlay.grab_button_focus()
		pause_overlay.visible = true

#Se o player faz algo errado, pune ele tirando 2 segundo do tempo restante
func punish_player():
	if $Timer.time_left - 2 <= 0:
		$Timer.wait_time = 0.01
	else:
		$Timer.wait_time = $Timer.time_left - 1
	$Timer.stop()
	$Timer.start()

#Se o player fez algo certo, recompensa ele acrescentando 1 segundo no tempo restante
func reward_player():
	$Timer.wait_time = $Timer.time_left + 3
	$Timer.stop()
	$Timer.start()

func _save_game() -> void:
	SaveGame.save_game(get_tree())

func _on_timer_timeout() -> void:
	print("Game Over")

func _on_button_pressed() -> void:
	#Gerenciamento do nível
	match Global.level:
		1: #Nível 1 - Deve pressionar o botão 1
			if $"Botão 1".pressed_this_level == true:
				$"Botão 1".pressed_this_level = false
				Global.level = 2
				reward_player()
			else:
				punish_player()
		2: #Nível 2 - Deve pressionar o botão 2
			if $"Botão 2".pressed_this_level == true:
				$"Botão 2".pressed_this_level = false
				Global.level = 3
				reward_player()
			else:
				punish_player()
		3: #Nível 2 - Deve pressionar o botão 3
			if $"Botão 3".pressed_this_level == true:
				$"Botão 3".pressed_this_level = false
				Global.level = 4
				reward_player()
			else:
				punish_player()
		4:
			pass
