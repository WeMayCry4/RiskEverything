extends CharacterBody2D

@export var moveSpeed: float = 100
@export var startingDirection: Vector2 = Vector2(0, 1)

@onready var animationTree = $AnimationTree

func _ready():
	print("ready")
	print(animationTree.get("parameters/idle/blend_position"))
	animationTree.set("parameters/idle/blend_position", startingDirection)

func _physics_process(delta):
	var inputDirection = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	velocity = inputDirection * moveSpeed
	
	move_and_slide()
