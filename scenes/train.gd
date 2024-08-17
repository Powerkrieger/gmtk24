extends CharacterBody2D


@export var speed = 100



func _process(delta):
	if get_parent().get_progress_ratio() <= 0.5 and get_parent().get_progress_ratio() >= 0.25:
		speed = speed - speed/30
		get_parent().set_progress(get_parent().get_progress() + speed * delta)
	elif get_parent().get_progress_ratio() < 0.25:
		get_parent().set_progress(get_parent().get_progress() + speed * delta)
	else:
		get_parent().set_progress(get_parent().get_progress() + 0 * delta)
		
		
