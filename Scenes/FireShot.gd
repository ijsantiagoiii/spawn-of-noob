extends Skill
class_name  FireShot

func _init(target) -> void:
	cooldown = 4.0
	animation_name = "Fire"
	texture = preload("res://Assets/Icons/Skills/48x48/skill_icons4.png")
	
	super._init(target)
	
func cast_spell(target):
	super.cast_spell(target)
	target.multi_shot()
	
