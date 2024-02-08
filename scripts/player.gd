extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -200.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var attack: bool = false 


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		attack=false
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("Attack"):
		attack=true
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction and is_on_floor():
		$AnimatedSprite2D.play("Walk")
		velocity.x = direction * SPEED
		attack=false
		
	elif direction and is_on_floor() and attack==true:
		$AnimatedSprite2D.play("Attack")
		velocity.x = direction * SPEED
		await $AnimatedSprite2D.animation_finished
		attack=false
		
	elif attack==true and is_on_floor():
		$AnimatedSprite2D.play("Attack")
		await $AnimatedSprite2D.animation_finished
		attack=false
		
	elif direction and not is_on_floor():
		$AnimatedSprite2D.play("Jump")
		velocity.x = direction * SPEED
		attack=false
	
	elif not is_on_floor():
		$AnimatedSprite2D.play("Jump")
		attack=false
		
	elif not direction and is_on_floor():
		$AnimatedSprite2D.play("Idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		attack=false
		
	if direction > 0:
		$AnimatedSprite2D.scale.x = 1
	
	if direction < 0:
		$AnimatedSprite2D.scale.x = -1
	
	
	move_and_slide()
