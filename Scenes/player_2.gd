extends CharacterBody2D

@export var character_animation : PackedScene

func _ready():
	var character = character_animation.instantiate()
	character.play("Idle")
