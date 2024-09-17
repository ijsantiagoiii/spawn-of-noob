extends CharacterBody2D
 
@export var projectile_node : PackedScene




##Player Movement & Collision : START
@export var max_speed = 150
@export var acceleration = 1500
@export var friction = 1200



@onready var axis = Vector2.ZERO
@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D
 
func _physics_process(delta: float) -> void:
	move(delta)
	
func get_intpu_axis():
	#var right = Input.is_action_pressed("move_right")
	#var left = Input.is_action_pressed("move_left")
	#
	#if right:
		#animation.play("walk")
	#elif left:
		#animation.play("walk")
	#else:
		#animation.play("idle")
		
	axis.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	axis.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return axis.normalized()

func move(delta):
	axis = get_intpu_axis()
	var h_direction = Input.get_axis("move_left","move_right")
	
	if h_direction!=0:
		sprite.flip_h = (h_direction==-1)
		
	if axis == Vector2.ZERO:
		apply_friction(friction * delta)
	else:
		apply_movement(axis * acceleration * delta)
		
	move_and_slide()

func apply_friction(amount):
		if velocity.length() > amount:
			velocity -= velocity.normalized() * amount
		else:
			velocity = Vector2.ZERO
			
func apply_movement(accel):
	velocity += accel
	velocity = velocity.limit_length(max_speed)
	
func _process(delta: float) -> void:
	var right = Input.is_action_pressed("move_right")
	var left = Input.is_action_pressed("move_left")
	
	if right:
		ap.play("Run")
	elif left:
		ap.play("Run")
	else:
		ap.play("Idle")
##Player Movement & Collision : END





###Player Movement by Mouse Click : START
#var speed = 135
#var click_position = Vector2()
#var target_position = Vector2()
#
#func _ready() -> void:
	#click_position = position
#
#func _physics_process(delta: float) -> void:
	#if Input.is_action_just_pressed("move_right_click"):
		#click_position = get_global_mouse_position()
		#
	#if position.distance_to(click_position) > 3:
		#target_position = (click_position - position).normalized()
		#velocity = target_position* speed
		#move_and_slide()
		#
#
###Player Movement by Mouse Click : END






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
