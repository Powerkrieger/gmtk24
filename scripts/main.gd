extends Node2D

@onready var train_timer = $TrainTimer
@onready var train_people_timer = $TrainPeopleTimer
@onready var sfx_coin = $sfx_coin

const trainSpawnerScene = preload("res://scenes/Train/train_spawner.tscn")
const trainPeopleGenerator = preload("res://scenes/People/trainpeoplegenerator.tscn")
@onready var popup_location = $UI/PopupLocation


var sum_delta = 0
var last_payday = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	train_timer.timeout.connect(_on_train_timer_timeout)
	train_people_timer.timeout.connect(_on_train_people_timer_timeout)
	Events.train_stopped.connect(train_people_timer.start)
	Events.train_gone.connect(train_timer.start)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sum_delta += delta
	if sum_delta - last_payday >= Game.paytime:
		if floori(Game.tax_rate + Game.people) > 0:
			sfx_coin.play()
			popup_location.popup(floori(Game.tax_rate * Game.people))
		print("payoff -> " + str(floori(Game.tax_rate * Game.people)))
		Game.gold += randi_range(floori(Game.tax_rate),floori(Game.tax_rate * Game.people))
		last_payday += Game.paytime

func _on_train_timer_timeout():
	var train = trainSpawnerScene.instantiate()
	get_tree().current_scene.add_child(train)

func _on_train_people_timer_timeout():
	for i in range(Game.people):
		var trainPeople = trainPeopleGenerator.instantiate()
		trainPeople.position = Vector2(128,384)
		get_tree().current_scene.add_child(trainPeople)
