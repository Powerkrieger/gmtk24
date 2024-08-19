extends Marker2D

@export var money_node : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

func popup(dollars : int):
	var money = money_node.instantiate()
	money.position = global_position
	money._set_dollars(dollars)
	var tween = get_tree().create_tween()
	tween.tween_property(money,
						"position",
						global_position + _get_direction(),
						0.75)
	
	get_tree().current_scene.add_child(money)
	
func _get_direction():
	return Vector2(randf_range(-1,1), -randf()) * 16
	
