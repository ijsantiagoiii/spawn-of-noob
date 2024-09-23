extends Skill
class_name WaterBall

func _init(target) -> void:
	cooldown = 1.0
	texture = preload("res://Assets/Icons/Skills/48x48/skill_icons48.png")
	animation_name = "Water"
	
	super._init(target)
	
func cast_spell(target):
	super.cast_spell(target)
	target.multi_shot(2,0.4,animation_name)
	
