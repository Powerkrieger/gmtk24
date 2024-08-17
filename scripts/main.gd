extends Node2D

@onready var train_timer = $TrainTimer
@onready var train_people_timer = $TrainPeopleTimer

const trainSpawnerScene = preload("res://scenes/Train/train_spawner.tscn")
const trainPeopleGenerator = preload("res://scenes/People/trainpeoplegenerator.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	train_timer.timeout.connect(_on_train_timer_timeout)
	train_people_timer.timeout.connect(_on_train_people_timer_timeout)
	Events.train_stopped.connect(train_people_timer.start)
	Events.train_gone.connect(train_timer.start)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_train_timer_timeout():
	var train = trainSpawnerScene.instantiate()
	get_tree().current_scene.add_child(train)

func _on_train_people_timer_timeout():
	for i in range(4):
		var trainPeople = trainPeopleGenerator.instantiate()
		trainPeople.position = Vector2(128,384)
		get_tree().current_scene.add_child(trainPeople)
