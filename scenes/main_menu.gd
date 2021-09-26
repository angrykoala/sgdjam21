extends Spatial

export(String, FILE) var main_scene_path


func _on_start_pressed() -> void:
	Utils.click.play()
	get_tree().change_scene(main_scene_path)
	Utils.current_scene = "game"
	Utils.change_music("theme")


func _on_exit_pressed() -> void:
	get_tree().quit()
