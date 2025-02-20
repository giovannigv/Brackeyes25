extends Node2D

@onready var fade_overlay = %FadeOverlay
@onready var pause_overlay = %PauseOverlay

func _ready() -> void:
	fade_overlay.visible = true
	
	if SaveGame.has_save():
		SaveGame.load_game(get_tree())
	
	pause_overlay.game_exited.connect(_save_game)
	
	$Timer.set_paused(true)

func _process(_delta: float) -> void:
	#Sistema de gerenciamento do estabilidade
	var stability = $Timer.time_left * 5/100 #Estabilidade do reator. Vai de 1 à 0
	var intensidade = 1.0 - stability
	$GPUParticles2D.process_material.initial_velocity_min = intensidade*50
	$GPUParticles2D.process_material.spread = intensidade*45
	$GPUParticles2D.set_self_modulate(Color(get_self_modulate().r - intensidade, get_self_modulate().g, get_self_modulate().b - intensidade))
	$GPUParticles2D.process_material.scale_min = lerp(0.5, 2.5, intensidade)
	$GPUParticles2D.process_material.scale_max = lerp(1.0, 3.0, intensidade)
	
	if stability <= 1.0 && stability >= 0.66:
		$Music.set_volume_db(0)
		$Music2.set_volume_db(-80)
		$Music3.set_volume_db(-80)
	elif stability <= 0.65 && stability >= 0.33:
		$Music.set_volume_db(-80)
		$Music2.set_volume_db(0)
		$Music3.set_volume_db(-80)
	elif stability <= 0.32 && stability >= 0:
		$Music.set_volume_db(-80)
		$Music2.set_volume_db(-80)
		$Music3.set_volume_db(0)

func _input(event) -> void:
	if event.is_action_pressed("pause") and not pause_overlay.visible:
		get_viewport().set_input_as_handled()
		get_tree().paused = true
		pause_overlay.grab_button_focus()
		pause_overlay.visible = true

#Se o player faz algo errado, pune ele tirando 2 segundo do tempo restante
func punish_player():
	if $Timer.time_left - 10 <= 0:
		$Timer.wait_time = 0.01
	else:
		$Timer.wait_time = $Timer.time_left - 1
	$Timer.stop()
	$Timer.start()

#Se o player fez algo certo, recompensa ele acrescentando 1 segundo no tempo restante
func reward_player():
	$Timer.wait_time = $Timer.time_left + 5
	$Timer.stop()
	$Timer.start()

func _save_game() -> void:
	SaveGame.save_game(get_tree())

func _on_timer_timeout() -> void:
	print("Game Over")

func _on_button_pressed() -> void:
	#Gerenciamento do nível
	match Global.level:
		
		1: #Nível 1 - Lower electrons' dance
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

#Quando o computador está desligado e é clicado, ele desativa a função de ligar e ativa os botões da senha
func _on_computer_clicked() -> void:
	$Computer/Sprite2D.set_visible(false)
	$Computer/pwd1.set_visible(true)
	$Computer/pwd2.set_visible(true)
	$Computer/pwd3.set_visible(true)
	$Computer/pwd4.set_visible(true)
	$Computer/btn_ok.set_visible(true)

func _on_btn_ok_button_pressed() -> void:
	if $Computer/pwd1.number == 0 && $Computer/pwd2.number == 4 && $Computer/pwd3.number == 5 && $Computer/pwd4.number == 1:
		$Computer.set_visible(false)
		$Computer/pwd1.set_visible(false)
		$Computer/pwd2.set_visible(false)
		$Computer/pwd3.set_visible(false)
		$Computer/pwd4.set_visible(false)
		$Computer/btn_ok.set_visible(false)
		Global.level = 1
		$Timer.set_paused(false)
