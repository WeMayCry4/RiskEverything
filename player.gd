extends CharacterBody2D

@export var moveSpeed: float = 100
@export var health: float = 100
@export var damage: float = 10
@export var starting_direction : Vector2 = Vector2(0,1)
var enemy_attack_cooldown = true
var enemy_inattack_range = false
var player_alive = true

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
var attack_ip = false

var health_boosts = 0

func _ready():
	update_animation_parameters(starting_direction)

func _physics_process(delta):
	update_health()
	if enemy_inattack_range: 
		enemy_attack()
	attack()
	if health <= 0:
		player_alive = false
		health = 0
		print ("player is dead")
		self.queue_free()
		
		
	var inputDirection = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	update_animation_parameters(inputDirection)
	
	velocity = inputDirection * moveSpeed
	
	move_and_slide()
	pick_new_state()

func update_animation_parameters(move_input: Vector2):
	if (move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/İdle/blend_position", move_input)

func pick_new_state():
	if (velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else : 
		state_machine.travel("İdle")
		
func giveSpeedBoost():
	moveSpeed += moveSpeed * (15/100)

func giveDamageBoost():
	damage += damage * (15/100)

func useHealthPotion():
	health_boosts -= 1
	health += health * (15/100)

func giveHealthPotion():
	print("yeyeyeyfishfoaihsdhfoi")
	health_boosts += 1


func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true


func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false

func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		
		health = health - 20
		enemy_attack_cooldown = false
		$attackcooldown.start(1.5)
		print(health)

func _on_attackcooldown_timeout():
	enemy_attack_cooldown = true

func attack():
	if Input.is_action_just_pressed("Attack"):
		global.player_current_attack = true


func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	global.player_current_attack = false
	attack_ip = false

func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	if health >= 100:
		healthbar.visible = false
	else :
		healthbar.visible = true

