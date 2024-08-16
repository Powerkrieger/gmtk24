extends Panel

@onready var tower = preload("res://scenes/Buildings/building1.tscn")
var currTile

func _on_gui_input(event: InputEvent) -> void:
	var tempTower = tower.instantiate()
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# Left mouse button pressed
			tempTower.process_mode = Node.PROCESS_MODE_DISABLED
			tempTower.get_node("Area").set_visible(true)
			add_child(tempTower)
			get_child(1).global_position = event.global_position
		else:
			# Left mouse buton was released
			get_child(1).queue_free()
			var path = get_tree().get_root().get_node("Main")
			path.add_child(tempTower)
			tempTower.global_position = event.global_position
			tempTower.get_node("Area").hide()
			
				
	# dragging
	if event is InputEventMouseMotion and event.button_mask == MOUSE_BUTTON_LEFT:
		get_child(1).global_position = event.global_position
