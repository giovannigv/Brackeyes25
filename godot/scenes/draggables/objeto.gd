extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D

var body_ref: Node2D #Armazena o body que o objeto está em contato
var draggable: bool = false #indica se o objeto é arrastável
var initialPos: Vector2 #Armazena a posição inicial do objeto. Utilizado quando o objeto é solto em um lugar inválido, sendo assim retornado à sua posição original
var is_inside_dropable: bool = false #Indica se o objeto se encontra em uma área onde pode ser solto
var offset: Vector2 #Distância entre o mouse e o objeto. Utilizado para suavizar a animação do objeto sendo arrastado

#Processamento do click e arrasto do objeto
func _process(_delta: float) -> void:
	if draggable == true: #Se o objeto for arrastável
		
		#Se clicou, guarda a posição inicial do objeto e a distância entre o objeto e o mouse
		if Input.is_action_just_pressed("click"):
			initialPos = global_position
			offset = get_global_mouse_position() - global_position
			Global.is_dragging = true
		
		#Se clicou e está segurando, arrasta o objeto
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("click"): #Se soltou o click, move o objeto para a dropzone caso esteja em uma, se não o objeto será retornado à sua posição inicial
			Global.is_dragging = false
			var tween = get_tree().create_tween()
			if is_inside_dropable == true:
				tween.tween_property(self, "position", body_ref.position, 0.2).set_ease(Tween.EASE_OUT)
			else:
				tween.tween_property(self, "global_position", initialPos, 0.2).set_ease(Tween.EASE_OUT)

#Quando o mouse entra, diminui levemente a escala do botão para ressaltar que é interativo
func _on_area_2d_mouse_entered() -> void:
	if not Global.is_dragging:
		draggable = true
		sprite_2d.texture = ResourceLoader.load("res://art/mug_hover.png")

#Quando o mouse sai, aumenta levemente a escala do botão para ressaltar que é interativo
func _on_area_2d_mouse_exited() -> void:
	if not Global.is_dragging:
		draggable = false
		sprite_2d.texture = ResourceLoader.load("res://art/mug.png")

#Se o objeto tocou na dropzone, altera a cor dela
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("dropable"):
		whereIsHolding(body.name)
		is_inside_dropable = true
		Global.pressingButton = true
		body_ref = body

#Se o objeto saiu da dropzone, altera a cor dela
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("dropable"):
		is_inside_dropable = false
		Global.pressingButton = false
		$"../Big F Button 1".isPressing = false
		$"../Big F Button 2".isPressing = false
		
func whereIsHolding(name: String):
	if(name == "Dropzone2"):
		print('2')
		$"../Big F Button 2".isPressing = true
		
	if(name == "Dropzone3"):
		print('1')
		$"../Big F Button 1".isPressing = true
		
	
