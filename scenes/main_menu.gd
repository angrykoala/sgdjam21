extends Spatial

export(String, FILE) var main_scene_path



func _on_start_pressed() -> void:
	get_tree().change_scene(main_scene_path)


func _on_exit_pressed() -> void:
	get_tree().quit()
