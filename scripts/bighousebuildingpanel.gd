extends Panel

@onready var tower = preload("res://scenes/Buildings/bigHouse/bigHouse.tscn")
var currTileLayer0
var mainSceneNodePath = "Main"
var uiPanelPath = "Main/UI/Panel"
var circleShadowNodeName = "AreaBlack"
var placeable = false
var house = Game.bigHouse

func _on_gui_input(event: InputEvent) -> void:
	if Game.gold >= house.cost:
		var tempTower = tower.instantiate()
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# Left mouse button pressed
				add_child(tempTower)
				tempTower.process_mode = Node.PROCESS_MODE_ALWAYS
				tempTower.get_node(circleShadowNodeName).set_visible(true)
				get_child(1).global_position = event.global_position
			else:
				# Left mouse button was released
				get_child(1).queue_free()
				if not placeable or (event.global_position.x >= get_tree().get_root().get_node(uiPanelPath).global_position.x):
					# dont build selected building
					pass
				else:
					# add node to main path making it appear on the canvas
					var path = get_tree().get_root().get_node(mainSceneNodePath)
					path.add_child(tempTower)
					tempTower.global_position = event.global_position
					tempTower.get_node(circleShadowNodeName).set_visible(false)
					Game.gold -= house.cost
					Game.housing_space += house.housing_space
				
					
		# dragging
		if event is InputEventMouseMotion and event.button_mask == MOUSE_BUTTON_LEFT:
			get_child(1).global_position = event.global_position
			var mapPath = get_tree().get_root().get_node("Main/Tilemap")
			var tile = mapPath.local_to_map(mapPath.to_local(get_global_mouse_position()))
			currTileLayer0 = mapPath.get_cell_atlas_coords(0, tile, false)  # 0 -> layer of tilemap
			var targets = get_child(1).get_node("BuildingDetector").get_overlapping_bodies()
			
			if (currTileLayer0 == Vector2i(1,1)) and not targets.size() > 1:  # there is one static body in there always, dunno
				get_child(1).get_node(circleShadowNodeName).modulate = Color(0, 255, 0)
				placeable = true
			else:
				get_child(1).get_node(circleShadowNodeName).modulate = Color(255, 0, 0)
				placeable = false
		
		
