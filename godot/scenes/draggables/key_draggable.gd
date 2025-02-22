extends Node2D

var body_ref: Node2D #Armazena o body que o objeto está em contato
var draggable: bool = false #indica se o objeto é arrastável
var initialPos: Vector2 #Armazena a posição inicial do objeto. Utilizado quando o objeto é solto em um lugar inválido, sendo assim retornado à sua posição original
var is_inside_dropable: bool = false #Indica se o objeto se encontra em uma área onde pode ser solto
var offset: Vector2 #Distância entre o mouse e o objeto. Utilizado para suavizar a animação do objeto sendo arrastado
var is_droped = false # Valida se ja foi deixada no ponto
var isOn = false

signal turnPCOn

@onready var sprite_2d: Sprite2D = $Sprite2D

#Processamento do click e arrasto do objeto
func _process(_delta: float) -> void:
	if draggable == true: #Se o objeto for arrastável
		if(!isOn):
			#Se clicou, guarda a posição inicial do objeto e a distância entre o objeto e o mouse
			if Input.is_action_just_pressed("click"):
				if(is_droped):
					turnPCOn.emit()
					isOn = true
					sprite_2d.texture = ResourceLoader.load("res://art/key/key_turn.png")
				initialPos = global_position
				offset = get_global_mouse_position() - global_position
				Global.is_key_dragging = true
				
			
			#Se clicou e está segurando, arrasta o objeto
			if Input.is_action_pressed("click"):
				global_position = get_global_mouse_position() - offset
			elif Input.is_action_just_released("click"): #Se soltou o click, move o objeto para a dropzone caso esteja em uma, se não o objeto será retornado à sua posição inicial
				Global.is_key_dragging = false
				var tween = get_tree().create_tween()
				if is_inside_dropable == true:
					tween.tween_property(self, "position", body_ref.position, 0.2).set_ease(Tween.EASE_OUT)
				else:
					tween.tween_property(self, "global_position", initialPos, 0.2).set_ease(Tween.EASE_OUT)


#Quando o mouse entra na chave
func _on_area_2d_mouse_entered() -> void:
	if not Global.is_key_dragging:
		draggable = true
		sprite_2d.texture = ResourceLoader.load("res://art/key/key_holding_hover.png")
	if is_droped:
		if isOn:
			sprite_2d.texture = ResourceLoader.load("res://art/key/key_turn_hover.png")
		else:
			sprite_2d.texture = ResourceLoader.load("res://art/key/key_use_hover.png")

#Quando o mouse sai da chave
func _on_area_2d_mouse_exited() -> void:
	if not Global.is_key_dragging:
		draggable = false
		sprite_2d.texture = ResourceLoader.load("res://art/key/key_holding.png")
	if is_droped:
		if isOn:
			sprite_2d.texture = ResourceLoader.load("res://art/key/key_turn.png")
		else:
			sprite_2d.texture = ResourceLoader.load("res://art/key/key_use.png")

#Se a chave tocou na dropzone, altera a sprite
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("dropable"):
		is_inside_dropable = true
		is_droped = true
		sprite_2d.texture = ResourceLoader.load("res://art/key/key_use.png")
		body_ref = body

#Se a chave saiu da dropzone, altera a cor dela
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("dropable"):
		is_inside_dropable = false
		sprite_2d.texture = ResourceLoader.load("res://art/key/key_holding_hover.png")
