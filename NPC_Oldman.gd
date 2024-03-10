extends CharacterBody2D

var rng = RandomNumberGenerator.new()
@export var notePaths : Array = []
var labels = []
@onready var rKey: Label = $RKey
@export var isInteractable = false
@onready var player = get_tree().get_first_node_in_group("player")
var labelCount = 0

func _physics_process(delta):
	pass

func _ready():
	for x in notePaths:
		var label_node : Label = get_node(x)
		labels.append(label_node)
	pass

func _process(delta):
	pass


	
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_R and isInteractable:
			if labels.size() != 0:
				print(labelCount)
				if labels.size() == labelCount:
					for x in labels:
						x.visible = false
				else:		
					for x in labels:
						x.visible = false
					rKey.visible = false
			
					labels[labelCount].visible = true
			
				
					labelCount += 1
			
			pass

func _on_area_2d_body_entered(body):
	if body.name == "Player" and labels.size() != 0:
		rKey.visible = true
		isInteractable = true
	pass

func _on_area_2d_body_exited(body):
	if body.name == "Player" and labels.size() != 0:
		rKey.visible = false
		isInteractable = false
		if labelCount == labels.size():
			labels.clear()
	pass
