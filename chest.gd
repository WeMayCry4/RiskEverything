extends Node2D

enum effects {HEALTH, SPEED, DAMAGE, NOTHING}

var rng = RandomNumberGenerator.new()
var inside: effects = effects.NOTHING
@onready var label = $Chest/Label
@export var isLootable = false
@onready var player = get_tree().get_first_node_in_group("player")

func _ready():
	print(player)
	label.visible = false
	
	var rndNum = rng.randi_range(0, 2)
	match rndNum:
		2:
			inside = effects.HEALTH
		1:
			inside = effects.DAMAGE
		0:
			inside = effects.SPEED		

func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	label.visible = true
	isLootable = true
	pass

func _on_area_2d_body_exited(body):
	label.visible = false
	isLootable = false
	pass

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_R and isLootable:
			match inside:
				effects.HEALTH:
					print("GAVE HEATLH")
					player.giveHealthPotion()
				effects.DAMAGE:
					print("GAVE DAMAGE")	
					player.giveDamageBoost()
				effects.SPEED:
					print("GAVE SPEED")
					player.giveSpeedBoost()
			queue_free()
			pass
