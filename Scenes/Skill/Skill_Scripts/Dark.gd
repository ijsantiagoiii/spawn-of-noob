extends Skill
class_name DarkBall

func _init(target) -> void:
	cooldown = 4.0
	texture = preload("res://Assets/Icons/Skills/48x48/skill_icons29.png")
	animation_name = "Dark"
	
	super._init(target)
	
func cast_spell(target):
	super.cast_spell(target)
	target.multi_shot(4,0.2,animation_name)
