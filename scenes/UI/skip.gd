extends Button

func _on_play_pressed() -> void:
	# TODO implement some restart logic
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	
