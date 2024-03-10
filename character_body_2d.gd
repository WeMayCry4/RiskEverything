extends CharacterBody2D

@export var moveSpeed: float = 100
@export var health: float = 100
@export var damage: float = 10
@export var starting_direction : Vector2 = Vector2(0,1)

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

var health_boosts = 0

func _ready():
	update_animation_parameters(starting_direction)

func _physics_process(delta):
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
