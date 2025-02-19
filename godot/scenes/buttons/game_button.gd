class_name GameButton
extends Node2D

var pressed_this_level = false #Se o botão já foi pressionado no nível atual
@warning_ignore("unused_signal")
signal button_pressed #Sinal que indica que um botão foi pressionado

#Quando o botão é clicado, faz algo
func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		emiteSinal()

#Função utilizada pelos botões para emitir o sinal de que foi pressionado
func emiteSinal():
	pressed_this_level = true
	emit_signal("button_pressed")

#Quando o mouse entra, diminui levemente a escala do botão para ressaltar que é interativo
func _on_area_2d_mouse_entered() -> void:
	scale = Vector2(scale.x - 0.01, scale.y - 0.01)

#Quando o mouse sai, aumenta levemente a escala do botão para ressaltar que é interativo
func _on_area_2d_mouse_exited() -> void:
	scale = Vector2(scale.x + 0.01, scale.y + 0.01)
