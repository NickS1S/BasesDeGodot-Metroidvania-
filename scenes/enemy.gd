extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -200.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var motion := Vector2()
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
	motion.y += gravity
	_flip()
	pass
	move_and_slide()
