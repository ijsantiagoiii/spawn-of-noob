extends CharacterBody2D
 
@export var projectile_node : PackedScene
@export var speed = 250
@export var gravity = 30
@export var max_gforce = 1000
@export var jump_force = -700

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D
 
func _physics_process(delta: float) -> void:
	pass
	
func _process(delta: float) -> void:
	#if !is_on_floor():
		#velocity.y += gravity
		#if velocity.y > max_gforce:
			#velocity.y = max_gforce

	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = jump_force
		ap.play("Jump")
	
	var h_direction = Input.get_axis("move_left","move_right")
	velocity.x = speed * h_direction
	
	if h_direction!=0:
		switch_direction(h_direction)
	
	play_animation(h_direction)
	move_and_slide()

func play_animation(h_direction):
	if is_on_floor():
		if h_direction == 0:
			ap.play("Idle")
		else:
			ap.play("Run")
	else:
		if velocity.y < 0:
			ap.play("Jump")
		else:
			ap.play("Fall")

func switch_direction(h_direction):
	sprite.flip_h = (h_direction == -1)
	sprite.position.x  = h_direction * 6





func single_shot(animation_name = "Fire"):
	#click_position = position
	var projectile = projectile_node.instantiate()

	projectile.play(animation_name)
 
	projectile.position = global_position
	projectile.direction = (get_global_mouse_position() - global_position).normalized()

	get_tree().current_scene.call_deferred("add_child",projectile)
 
func multi_shot(count: int = 3, delay: float = 0.3, animation_name = "Fire"):
	#click_position = position
	for i in range(count):
		single_shot(animation_name)
		await get_tree().create_timer(delay).timeout
 
func angled_shot(angle,i):
	#click_position = position
	var projectile = projectile_node.instantiate()
 
	if i % 2 == 0:
		projectile.play("Dark")
	else:
		projectile.play("Fire")
 
	projectile.position = global_position
	projectile.direction = Vector2(cos(angle),sin(angle))
 
	get_tree().current_scene.call_deferred("add_child",projectile)
 
func radial(count):
	#click_position = position
	for i in range(count):
		angled_shot( (float(i) / count ) * 2.0 * PI, i )
