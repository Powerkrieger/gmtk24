extends CharacterBody2D

var direction
var direction_vec
var SPEED = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Animation.play("run_right")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match direction:
			0: 
				direction_vec = Vector2(0, -1)
				$Animation.play("run_up")
			1: 
				direction_vec = Vector2(1, -1)
				$Animation.play("run_up_right")
			2: 
				direction_vec = Vector2(1, 0)
				$Animation.play("run_right")
			3: 
				direction_vec = Vector2(1, 1)
				$Animation.play("run_down_right")
			4: 
				direction_vec = Vector2(0, 1)
				$Animation.play("run_down")
			5:
				direction_vec = Vector2(-1, 1)
				$Animation.play("run_down_left")
			6:
				direction_vec = Vector2(-1, 0)
				$Animation.play("run_left")
			7:
				direction_vec = Vector2(-1, -1)
				$Animation.play("run_up_left")
				
	velocity = direction_vec * SPEED
	var collision = move_and_collide(velocity*delta)
	if collision:
		_choose_new_direction(collision.get_normal())
	
	
func _choose_new_direction(old_direction: Vector2):
	match old_direction:
		Vector2(0, 1): 
			direction = randi_range(3, 5)
		Vector2(0, -1):
			direction = randi_range(0, 2)
			if direction == 2:
				direction = 7
		Vector2(1, 0):
			direction = randi_range(1, 3)
		Vector2(-1, 0):
			direction = randi_range(5, 7)
		_:
			direction = randi_range(0, 7)
			
	
	
	
