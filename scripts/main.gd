extends Node2D

@onready var timer = $Timer
const trainSpawnerScene = preload("res://scenes/Train/train_spawner.tscn")
const trainPeopleGenerator = preload("res://scenes/People/trainpeoplegenerator.tscn")


var sum_delta = 0
var last_payday = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.timeout.connect(_on_timer_timeout)
	Events.train_gone.connect(timer.start)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sum_delta += delta
	if sum_delta - last_payday >= Game.paytime:
		print("payoff -> " + str(floori(Game.tax_rate * Game.people)))
		Game.gold += floori(Game.tax_rate * Game.people)
		last_payday += Game.paytime
		

func _spawn_trainpeople():
	var trainPeople = trainPeopleGenerator.instantiate()
	get_tree().current_scene.add_child(trainPeople)

func _on_timer_timeout():
	var train = trainSpawnerScene.instantiate()
	get_tree().current_scene.add_child(train)
