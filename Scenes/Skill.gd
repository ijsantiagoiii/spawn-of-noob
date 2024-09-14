extends Resource
class_name Skill

var cooldown : float
var texture : Texture2D
var animation_name : String

func _init(target) -> void:
	target.cooldown.max_value = cooldown
	target.texture_normal = texture
	target.timer.wait_time = cooldown
	
func cast_spell(target):
	print(animation_name + " caster from " + target.name)
