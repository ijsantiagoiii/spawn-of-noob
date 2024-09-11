extends CharacterBody2D
 
@export var projectile_node : PackedScene
 
##Testing
#func _ready():
	#await get_tree().create_timer(1).timeout
	#single_shot()
	#
	#await get_tree().create_timer(1).timeout
	#multi_shot()
	#
	#await get_tree().create_timer(1).timeout
	#radial(8)

func single_shot(animation_name = "Fire"):
	var projectile = projectile_node.instantiate()
 
	projectile.play(animation_name)
 
	projectile.position = global_position
	projectile.direction = (get_global_mouse_position() - global_position).normalized()
 
	get_tree().current_scene.call_deferred("add_child",projectile)
 
 
func multi_shot(count: int = 3, delay: float = 0.3, animation_name = "Fire"):
	for i in range(count):
		single_shot(animation_name)
		await get_tree().create_timer(delay).timeout
 
func angled_shot(angle,i):
	var projectile = projectile_node.instantiate()
 
	if i % 2 == 0:
		projectile.play("Dark")
	else:
		projectile.play("Fire")
 
	projectile.position = global_position
	projectile.direction = Vector2(cos(angle),sin(angle))
 
	get_tree().current_scene.call_deferred("add_child",projectile)
 
 
func radial(count):
	for i in range(count):
		angled_shot( (float(i) / count ) * 2.0 * PI, i )
