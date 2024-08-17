extends CharacterBody2D

var speed = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_parent().get_progress_ratio() == 1:
		queue_free()
		get_parent().set_progress(0)
	get_parent().set_progress(get_parent().get_progress() + speed * delta)
