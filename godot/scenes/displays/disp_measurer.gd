extends Node2D

@onready var sprite_pointer: Sprite2D = $Sprite2D/SpritePointer

func update_rating(value: float)-> void:
	print("start: ", sprite_pointer.rotation_degrees)
	if(sprite_pointer.rotation_degrees <= 90):
		sprite_pointer.rotation_degrees += value
	else:
		print("Is Overflowing")
