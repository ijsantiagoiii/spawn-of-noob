extends Skill
class_name Ultimate

func _init(target) -> void:
	cooldown = 10.0
	texture = preload("res://Assets/Icons/Skills/48x48/skill_icons13.png")
	animation_name = "Ultimate"
	
	super._init(target)
	
func cast_spell(target):
	super.cast_spell(target)
	target.radial(18)
