extends Node2D

#Quando o botão é clicado, faz algo
func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		print("Botão apertado")

#Quando o mouse entra, diminui levemente a escala do botão para ressaltar que é interativo
func _on_area_2d_mouse_entered() -> void:
	scale = Vector2(scale.x - 0.01, scale.y - 0.01)

#Quando o mouse sai, aumenta levemente a escala do botão para ressaltar que é interativo
func _on_area_2d_mouse_exited() -> void:
	scale = Vector2(scale.x + 0.01, scale.y + 0.01)
