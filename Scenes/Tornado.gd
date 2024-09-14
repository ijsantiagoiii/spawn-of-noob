extends Skill
class_name Tornado

func _init(target) -> void:
	cooldown = 1.0
	texture = preload("res://Assets/Icons/Skills/48x48/skill_icons24.png")
	animation_name = "Torndo"
	
	super._init(target)
	
func cast_spell(target):
	super.cast_spell(target)
	target.single_shot(animation_name)
