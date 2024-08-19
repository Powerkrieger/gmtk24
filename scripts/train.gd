extends CharacterBody2D

@export var speed = 200
@onready var timer = $Timer
var stopping = 1
@onready var sfx_train_approaching = $sfx_train_approaching
@onready var sfx_train_departing = $sfx_train_departing

func _ready():
	sfx_train_approaching.play()
	timer.timeout.connect(_on_timer_timeout)

func _process(delta):
	if get_parent().get_progress_ratio() == 1:
		queue_free()
		Events.train_gone.emit(Game.waitTime)
		Game.waitTime = Game.waitTime + 1
	if stopping == 1 and get_parent().get_progress_ratio() <= 0.45 and get_parent().get_progress_ratio() >= 0.35:
		speed = speed - speed/50
		get_parent().set_progress(get_parent().get_progress() + speed * delta)
	elif stopping == 1 and get_parent().get_progress_ratio() < 0.35:
		get_parent().set_progress(get_parent().get_progress() + speed * delta)
	elif stopping == 1:
		stopping = 0
		speed = 0
		Events.train_stopped.emit(1)
		timer.start(5)
	elif stopping == 0 and speed > 0:
		speed = speed + 1
		get_parent().set_progress(get_parent().get_progress() + speed * delta)

func _on_timer_timeout():
	speed = 1
	sfx_train_departing.play()
