extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -200.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var motion := Vector2()

var player = null
func _ready():
	motion.x = SPEED
	pass 

func _next_to_left_wall() -> bool:
	return $LeftR.is_colliding()

func _next_to_right_wall() -> bool:
	return $RightR.is_colliding()

func _floor_detection() -> bool:
	return $AnimatedSprite2D/FloorDetection.is_colliding()

func _flip():
	if _next_to_left_wall() or _next_to_right_wall() or !_floor_detection():
		motion.x *= -1
		$AnimatedSprite2D.scale.x *= -1


func _process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if player != null:
		motion = position.direction_to(player.position)
	else:
		move_and_slide()
	_flip()
	pass


func _on_area_2d_body_entered(body):
	if body != self:
		player = body


func _on_area_2d_area_exited(area):
	player = null
