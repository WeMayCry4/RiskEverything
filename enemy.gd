extends CharacterBody2D

var speed = 45
var health = 50
var damage
var dead = false
var player_chase = false
var player = null
var player_inattack_zone

func _ready():
	dead = false

func _physics_process(delta):
	if player_inattack_zone:
		deal_with_damage()
	
	if !dead:
		$Area2D/CollisionShape2D.disabled = false
	if player_chase and player != null:
		position += (player.position - position)/speed
		$AnimatedSprite2D.play("walk")
		if(player.position.x - position.x) < 0 :
			$AnimatedSprite2D.flip_h = true
		else : $AnimatedSprite2D.flip_h = false	
		
	else :
		$AnimatedSprite2D.play("idle")
		if dead: $Area2D/CollisionShape2D.disabled = true



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
	
func enemy(): 
	pass

func _on_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true



func _on_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false
		
func deal_with_damage():
	if player_inattack_zone and global.player_current_attack == true:
		health = health - 25
		print("slime health:", health)
		if health <= 0:
			health = 0
			self.queue_free()
		
