extends Node2D

var rng = RandomNumberGenerator.new()
var possibilities = [$HealthBoost, $SpeedBoost, $DamageBoost]
var inside = null

func _ready():
	inside = possibilities[rng.randi_range(0, 2)]

func _process(delta):
	pass
