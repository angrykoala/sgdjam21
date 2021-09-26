extends Spatial


export(String, FILE) var main_menu_path


func _on_ok_pressed() -> void:
	Utils.click.play()
	get_tree().change_scene(main_menu_path)
