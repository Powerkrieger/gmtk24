extends Node2D

@onready var timer = $Timer
const trainSpawnerScene = preload("res://scenes/train_spawner.tscn")
const trainPeopleGenerator = preload("res://scenes/People/trainpeoplegenerator.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.timeout.connect(_on_timer_timeout)
	Events.train_gone.connect(timer.start)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _spawn_trainpeople():
	var trainPeople = trainPeopleGenerator.instantiate()
	get_tree().current_scene.add_child(trainPeople)

func _on_timer_timeout():
	var train = trainSpawnerScene.instantiate()
	get_tree().current_scene.add_child(train)
