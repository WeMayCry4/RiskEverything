extends CharacterBody2D

var rng = RandomNumberGenerator.new()
@onready var label = $Label
@export var isInteractable = false
@onready var player = get_tree().get_first_node_in_group("player")
@onready var labelList = [Label]
var labelCount = 0

func _physics_process(delta):
	pass

func _ready():
	label.visible = false

func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	label.visible = true
	isInteractable = true
	pass

func _on_area_2d_body_exited(body):
	label.visible = false
	isInteractable = false
	pass
	
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_R and isInteractable:
			for x in labelList:
				x.visible = false
			labelList[labelCount].visible = true
			labelCount += 1
			pass
