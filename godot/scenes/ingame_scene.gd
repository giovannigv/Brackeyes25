extends Node2D

@onready var fade_overlay = %FadeOverlay
@onready var pause_overlay = %PauseOverlay
@onready var game_over_overlay = %GameOverOverlay

var count_slap: int = 0
var isSFXPlaying = false

func _ready() -> void:
	fade_overlay.visible = true
	
	if SaveGame.has_save():
		SaveGame.load_game(get_tree())
	
	pause_overlay.game_exited.connect(_save_game)
	game_over_overlay.game_exited.connect(_save_game)
	
	#set restart Game
	$Timer.set_paused(true)
	Global.level = 0

func _process(_delta: float) -> void:
	#Sistema de gerenciamento do estabilidade
	var stability = $Timer.time_left * 4/100 #Estabilidade do reator. Vai de 1 à 0
	
	#Sistema de gerenciamento da música
	if stability <= 1.0 && stability >= 0.56:
		var tween = create_tween()
		tween.tween_property($SFX/Music, "volume_db", 0, 0.1)
		tween.tween_property($SFX/Music2, "volume_db", -80, 0.1)
		tween.tween_property($SFX/Music3, "volume_db", -80, 0.1)
		#$SFX/alarm2.stop()
		#$SFX/alarm1.stop()
	elif stability <= 0.55 && stability >= 0.33:
		#$SFX/alarm2.stop()
		var tween = create_tween()
		tween.tween_property($SFX/Music, "volume_db", -80, 0.1)
		tween.tween_property($SFX/Music2, "volume_db", -0, 0.1)
		tween.tween_property($SFX/Music3, "volume_db", -80, 0.1)
		
		playSound($SFX/alarm2)
	elif stability <= 0.32 && stability >= 0:
		#$SFX/alarm1.stop()
		var tween = create_tween()
		tween.tween_property($SFX/Music, "volume_db", -80, 0.1)
		tween.tween_property($SFX/Music2, "volume_db", -80, 0.1)
		tween.tween_property($SFX/Music3, "volume_db", 0, 0.1)
		
		#$SFX/alarm2.play()

func playSound(sound: AudioStreamPlayer2D):
	if !isSFXPlaying:
		sound.play()
		isSFXPlaying= true

func _on_alarm_1_finished() -> void:
	isSFXPlaying= false

func _on_alarm_2_finished() -> void:
	isSFXPlaying= false


func _input(event) -> void:
	if event.is_action_pressed("pause") and not pause_overlay.visible:
		get_viewport().set_input_as_handled()
		get_tree().paused = true
		pause_overlay.grab_button_focus()
		pause_overlay.visible = true

func game_over() -> void:
	$SFX/Music3.stop()
	$SFX/explosion.play()
	await get_tree().create_timer(3).timeout # wait 3 sec to show and pause game
	get_viewport().set_input_as_handled()
	get_tree().paused = true
	game_over_overlay.visible = true
	game_over_overlay.grab_button_focus()

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
	game_over()

func _on_button_pressed() -> void:
	#Gerenciamento do nível
	match Global.level:
		
		0:
			if $btn_file.pressed_this_level == true:
				$btn_file.pressed_this_level = false
				$"Tutorial/TextureRect/Tutorial 1".set_visible(false)
				$"Tutorial/TextureRect/Tutorial 2".set_visible(false)
				$"Tutorial/TextureRect/Tutorial 3".set_visible(true)
		
		#Lower electrons' dance
		1:
			if $Slider.pressed_this_level == true:
				$Slider.pressed_this_level = false
				reward_player()
			else:
				punish_player()
		2: 
			if $"Blue Button 1".pressed_this_level == true || $"Blue Button 2".pressed_this_level == true:
				Global.level = 3
				reward_player()
				$"Tutorial Computer".text = "Good. Now insert the\nbase substance capsule.\nYou can do it by\ninteracting with the pad."
				$Pad.showOrder(0)
			else:
				punish_player()
		
		#Insert Base Substance Capsule
		3:
			if $"Pad".pressed_this_level == true:
				$"Pad".pressed_this_level = false
			else:
				punish_player()
		4:
			if $"Selector".pressed_this_level == true:
				$"Selector".pressed_this_level = false
				Global.level = 5
			else:
				punish_player()
		
		#Rewind the protons in the inner layer
		5: 
			if $Dial.pressed_this_level == true:
				$Dial.pressed_this_level = false
				if $Dial.gotRight == true:
					Global.level = 6
					reward_player()
		
		6:
			if $"Blue Button 2".pressed_this_level == true:
				$"Blue Button 2".pressed_this_level = false
				
		
		#Reduce Core Power
		7:
			if $Slap.pressed_this_level == true:
				$Slap.pressed_this_level = false
				count_slap += 1
				match count_slap:
					
					1:
						$"Tutorial Computer".text = "Again."
					
					2:
						$"Tutorial Computer".text = "Hit me harder!"
					
					4:
						$"Tutorial Computer".text = "Harder, daddy!"
					
					6:
						$"Tutorial Computer".text = "Oh yeah! I like it!"
					
					8:
						$"Tutorial Computer".text = "Ok, now you're hurting me."
					
					10:
						$"Tutorial Computer".text = "I'm back. You can stop now!"
						Global.level = 8
						reward_player()
						await get_tree().create_timer(3).timeout
						showLevelObjective()
						$Slap.set_visible(false)
			else:
				punish_player()
		8:
			Global.level = 9
			reward_player()
			showLevelObjective()
		
		9:
			Global.level = 10
			reward_player()
			showLevelObjective()
		
		10:
			Global.level = 11
			$Timer.stop()
			showLevelObjective()
		
		#8: Nao pode se mexer
		#9: Gaveta ta sempre disponivel, mas nessa hora tem q pedir para clicar no leitor
		#10: Apertar os dois botoes ao mesmo tempo
		#11: Devoler chaves
		
		
func showLevelObjective():
	match Global.level:
		6:
			$"Tutorial Computer".text = "Hold the other Blue Button to insert protons on the inner layer."
		8:
			$"Tutorial Computer".text = "DON'T MOVE! To maintain levels of Bibiri Babiri."
		9:
			if(Global.gotDisk):
				$"Tutorial Computer".text = "INSERT Floppy disk into the reader! \nNOW!"
			else:
				$"Tutorial Computer".text = "To Restore core temporal Health, you need to find \nTODAY\n Floppy Disk"
		10:
			$"Tutorial Computer".text = "To SHUTDOWN Engine, \nyou have to press at the same time 2 BIG Buttons!"
		11:
			$"Tutorial Computer".text = "Congrats! You actually avoid a HUGE meltdown Mayham. \n Before you go, don't forget to send the keys back to Wesley"
			
		

#Quando o computador está desligado e é clicado, ele desativa a função de ligar e ativa os botões da senha
func _on_computer_clicked() -> void:
	$Computer/pwd1.set_visible(true)
	$Computer/pwd2.set_visible(true)
	$Computer/pwd3.set_visible(true)
	$Computer/pwd4.set_visible(true)
	$Computer/Pass.set_visible(true)
	$Computer/btn_ok.set_visible(true)
	
	if $"Tutorial/TextureRect/Tutorial 1".visible == true:
		$"Tutorial/TextureRect/Tutorial 1".set_visible(false)
		$"Tutorial/TextureRect/Tutorial 2".set_visible(true)
		$"Tutorial/TextureRect/Tutorial 3".set_visible(false)

#Verifica se a senha está correta
func _on_btn_ok_button_pressed() -> void:
	if $Computer/pwd1.number == 0 && $Computer/pwd2.number == 4 && $Computer/pwd3.number == 5 && $Computer/pwd4.number == 1:
		$Computer.set_visible(false)
		$Computer/pwd1.set_visible(false)
		$Computer/pwd2.set_visible(false)
		$Computer/pwd3.set_visible(false)
		$Computer/pwd4.set_visible(false)
		$Computer/Pass.set_visible(false)
		$Computer/btn_ok.set_visible(false)
		$"Tutorial/TextureRect/Tutorial 1".set_visible(false)
		$"Tutorial/TextureRect/Tutorial 2".set_visible(false)
		$"Tutorial/TextureRect/Tutorial 3".set_visible(false)
		$"Tutorial Computer".set_visible(true)
		Global.level = 1
		$Timer.set_paused(false)
		$Tutorial/AnimationPlayer.play_backwards("move_tutorial")

#Ativa quando o slider foi colocado no máximo
func _on_btn_default_slider_max() -> void:
	if Global.level == 1:
		Global.level = 2
		reward_player()
		$"Tutorial Computer".text = "Deposit the electrons\nto the channel\nby clicking\nthe blue button."

#Ativa quando o jogador terminou a sequência
func _on_pad_pad_finished() -> void:
	Global.level = 4
	reward_player()
	$"Tutorial Computer".text = "Now use the selector\nto pick the\ncorrect rail that\nthe capsule must go."
	$"Selector".started = true
	$"Selector".chooseRandomButton()

#Ativa quando o jogador clica no botão correto
func _on_selector_picked_correct() -> void:
	$"Selector".started = false
	Global.level = 5
	reward_player()
	$"Tutorial Computer".text = "Please rewind the protons in the inner layer.\nIt can be done by using the dial to match the wave ondulation."

func _on_dial_finish_turn() -> void:
	Global.level = 6
	reward_player()
	showLevelObjective()

#Ativa quando o computador é ligado
func _on_computer_pc_on() -> void:
	$KeyDropzone.queue_free()

#Ativa quando a barra estiver cheia
func _on_blue_button_2_button_pressed() -> void:
	Global.level = 7
	reward_player()
	$"Tutorial Computer".text = "I'm malfunctioning. Hit me until I come back to my senses."
	await get_tree().create_timer(3).timeout
	$Slap.set_visible(true)
	

func _on_btn_drawer_got_floppy_disk() -> void:
	Global.gotDisk = true
	showLevelObjective()
	
