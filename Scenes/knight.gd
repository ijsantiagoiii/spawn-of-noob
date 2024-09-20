extends CharacterBody2D

@export var speed = 80


##Player Movement & Collision : START
@export var max_speed = 300
@export var acceleration = 1500
@export var friction = 1200

@onready var axis = Vector2.ZERO
@onready var animation_tree = $Knight_AnimationTree
func _physics_process(delta: float) -> void:
	move(delta)
	
func get_intpu_axis():
	axis.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	axis.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return axis.normalized()

func move(delta):
	axis = get_intpu_axis()
	
	if axis == Vector2.ZERO:
		apply_friction(friction * delta)
	else:
		apply_movement(axis * acceleration * delta)
	
	animation_tree.set("parameters/Idle/blend_position",velocity)	
	move_and_slide()

func apply_friction(amount):
		if velocity.length() > amount:
			velocity -= velocity.normalized() * amount
		else:
			velocity = Vector2.ZERO
			
func apply_movement(accel):
	velocity += accel
	velocity = velocity.limit_length(max_speed)
##Player Movement & Collision : END



#func _physics_process(delta: float) -> void:
	#var velocity = Vector2.ZERO
	#if Input.is_action_just_pressed("move_right"):
		#velocity.x += 1
	#if Input.is_action_just_pressed("move_left"):
		#velocity.x -= 1
	#if Input.is_action_just_pressed("move_down"):
		#velocity.y += 1
	#if Input.is_action_just_pressed("move_up"):
		#velocity.y -= 1
#
	#move_and_slide()
