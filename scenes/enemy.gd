extends CharacterBody2D

const SPEED = 90
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player = null

func _ready():
	velocity.x = -SPEED
	$AnimatedSprite2D.play("Walk")
	pass 

func _next_to_left_wall() -> bool:
	print("Colisione izquierda")
	return $LeftR.is_colliding()

func _next_to_right_wall() -> bool:
	print("Colisione derecha")
	return $RightR.is_colliding()

func _floor_detection() -> bool:
	print("Colisione caida")
	return $AnimatedSprite2D/FloorDetection.is_colliding()

func flip():
	if _next_to_left_wall() or _next_to_right_wall() or !_floor_detection():
		velocity.x *= SPEED
		$AnimatedSprite2D.scale.x *= -1


@warning_ignore("unused_parameter")
func _process(delta):
	velocity.x = -SPEED
	flip()
	move_and_slide()
	print("Posición del enemigo: ", position)
	pass

func follow():
	if player != null:
		velocity = position.direction_to(player.position)*SPEED
		
func _on_area_2d_body_entered(body):
	if body != self:
		player = body


func _on_area_2d_area_exited(area):
	player = null
