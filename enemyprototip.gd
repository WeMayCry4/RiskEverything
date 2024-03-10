extends CharacterBody2D

var speed = 45
var player_chase = false
var player = null

func _physics_process(delta):
	if player_chase:
		position += (player.position - position)/speed
		$AnimatedSprite2D.play("walk")
	else :
		$AnimatedSprite2D.play("idle")



func _on_area_2d_body_entered(body):
	player = body
	player_chase = true
	



func _on_area_2d_body_exited(body):
	player = null
	player_chase = false


func _on_area_2d_2_body_entered(body):
	player = body
	player_chase = false


func _on_area_2d_2_body_exited(body):
	player = body 
	player_chase = true
