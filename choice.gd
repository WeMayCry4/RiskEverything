extends Node2D

@onready var timer: Timer = $Timer
@onready var bar: ColorRect = $bar
@onready var first: Button = $first
@onready var second: Button = $second
@export var drainSpeed: float = 0.5
@onready var barPosition: Vector2 = bar.position

var barSize: Vector2 = Vector2(100, 20)


func _ready():
	timer.start(100)
	
func FirstAction():
	queue_free()

func SecondAction():
	queue_free()	

func chooseRandomly():
	var rng = RandomNumberGenerator.new()
	var randomNum = rng.randi_range(0, 1)
	if randomNum == 0:
		FirstAction()
	else:
		SecondAction()	

func stop():
	timer.stop()	
	queue_free()

func barProgress(delta):
	bar.size = barSize
	bar.position = barPosition
	barSize = Vector2(barSize.x - 0.5, barSize.y)
	barPosition = Vector2(barPosition.x + 0.2, barPosition.y)
	
	

func _process(delta):
	if barSize.x <= 0:	
		stop()
	if !timer.is_stopped() and barSize.x != 0:
		barProgress(delta)
		


func _on_second_pressed():
	FirstAction()


func _on_first_pressed():
	SecondAction()
