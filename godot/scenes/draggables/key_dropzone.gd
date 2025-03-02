extends StaticBody2D

#Altera a cor da dropzone
func _ready() -> void:
	modulate = Color(Color.DIM_GRAY, 0.7)

#Controla a visibilidade da dropzone se algum objeto estiver sendo carregado
func _process(_delta: float) -> void:
	if Global.is_key_dragging:
		visible = true
	else:
		visible = false
	
	if Global.level == 0:
		process_mode = PROCESS_MODE_INHERIT
		
	else:
		process_mode = PROCESS_MODE_DISABLED
