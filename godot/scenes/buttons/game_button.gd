class_name GameButton
extends Node2D

@warning_ignore("unused_signal")
signal button_pressed #Sinal que indica que um botão foi pressionado
@onready var sprite_2d: Sprite2D = $Sprite2D

@onready var btn_label := get_tree().get_root().get_node("IngameScene").get_node("btn_label")
var pressed_this_level = false #Se o botão já foi pressionado no nível atual

var texture_path: String
var texture_path_hover: String

func _ready() -> void:
	if sprite_2d.texture != null:
		texture_path = sprite_2d.texture.get_path()
		texture_path_hover = texture_path.insert(sprite_2d.texture.get_path().length() - 4, "_hover")

#Quando o botão é clicado, faz algo
func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		emiteSinal()

#Função utilizada pelos botões para emitir o sinal de que foi pressionado
func emiteSinal():
	pressed_this_level = true
	emit_signal("button_pressed")

#Quando o mouse entra, mostra o Hover
func _on_area_2d_mouse_entered() -> void:
	if ResourceLoader.exists(texture_path_hover) == true:
		sprite_2d.texture = ResourceLoader.load(texture_path_hover)
	else:
		scale = Vector2(scale.x - 0.01, scale.y - 0.01)
	if Global.level != 0:
		btn_label.text = self.name

#Quando o mouse sai, tira o Hover
func _on_area_2d_mouse_exited() -> void:
	if ResourceLoader.exists(texture_path_hover) == true:
		sprite_2d.texture = ResourceLoader.load(texture_path)
	else:
		scale = Vector2(scale.x + 0.01, scale.y + 0.01)
	btn_label.text = ""
	
