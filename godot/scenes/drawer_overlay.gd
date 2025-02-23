extends CenterContainer
@onready var disk_1: Sprite2D = $Disk1
@onready var disk_2: Sprite2D = $Disk2
@onready var disk_3: Sprite2D = $Disk3
@onready var disk_4: Sprite2D = $Disk4
@onready var disk_5: Sprite2D = $Disk5
@onready var audio_wrong: AudioStreamPlayer2D = $AudioWrong
@onready var audio_correct: AudioStreamPlayer2D = $AudioCorrect

signal finish_event

# DISK 1
func _on_disk1_area_2d_mouse_entered() -> void:
	disk_1.texture = ResourceLoader.load("res://art/drawer/disk1_hover.png")

func _on_disk1_area_2d_mouse_exited() -> void:
	disk_1.texture = ResourceLoader.load("res://art/drawer/disk1.png")

# DISK 2
func _on_disk2_area_2d_mouse_entered() -> void:
	disk_2.texture = ResourceLoader.load("res://art/drawer/disk2_hover.png")

func _on_disk2_area_2d_mouse_exited() -> void:
	disk_2.texture = ResourceLoader.load("res://art/drawer/disk2.png")

# DISK 3
func _on_disk3_area_2d_mouse_entered() -> void:
	disk_3.texture = ResourceLoader.load("res://art/drawer/disk3_hover.png")

func _on_disk3_area_2d_mouse_exited() -> void:
	disk_3.texture = ResourceLoader.load("res://art/drawer/disk3.png")

# DISK 4
func _on_disk4_area_2d_mouse_entered() -> void:
	disk_4.texture = ResourceLoader.load("res://art/drawer/disk4_hover.png")

func _on_disk4_area_2d_mouse_exited() -> void:
	disk_4.texture = ResourceLoader.load("res://art/drawer/disk4.png")

# DISK 5
func _on_disk5_area_2d_mouse_entered() -> void:
	disk_5.texture = ResourceLoader.load("res://art/drawer/disk5_hover.png")

func _on_disk5_area_2d_mouse_exited() -> void:
	disk_5.texture = ResourceLoader.load("res://art/drawer/disk5.png")

# Press Button
func _on_disk1_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		audio_wrong.play()


func _on_disk2_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		audio_correct.play()
		await get_tree().create_timer(1).timeout
		Global.gotDisk = true
		finish_event.emit()


func _on_disk3_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		audio_wrong.play()


func _on_disk4_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		audio_wrong.play()


func _on_disk5_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		audio_wrong.play()
