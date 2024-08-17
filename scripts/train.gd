extends CharacterBody2D

@export var speed = 200
@onready var timer = $Timer
var stopping = 1


func _ready():
	timer.timeout.connect(_on_timer_timeout)
	Events.train_stopped.connect(timer.start)
	

func _process(delta):
	if get_parent().get_progress_ratio() == 1:
		queue_free()
		Events.train_gone.emit()
	if stopping == 1 and get_parent().get_progress_ratio() <= 0.45 and get_parent().get_progress_ratio() >= 0.35:
		speed = speed - speed/50
		get_parent().set_progress(get_parent().get_progress() + speed * delta)
	elif stopping == 1 and get_parent().get_progress_ratio() < 0.35:
		get_parent().set_progress(get_parent().get_progress() + speed * delta)
	elif stopping == 1:
		stopping = 0
		speed = 0
		Events.train_stopped.emit()
	elif stopping == 0 and speed > 0:
		speed = speed + 1
		get_parent().set_progress(get_parent().get_progress() + speed * delta)

func _on_timer_timeout():
	speed = 1
