extends Spatial


export(String, FILE) var main_menu_path

onready var results=$CanvasLayer/Panel/Label

func _on_ok_pressed() -> void:
	Utils.click.play()
	get_tree().change_scene(main_menu_path)

func _ready():

	for fruit in Utils.frankenfruits_list:
		var frankenfruit=Utils.frankenfruits_list[fruit][0]
		var count=Utils.frankenfruits_list[fruit][1]
		# results.text=results.text+"\n"+str(count)+" x "+frankenfruit.nombre+" = "+str(count*frankenfruit.puntuation)
		results.text=results.text+"\n"+str(count)+" x "+fruit
	results.text=results.text+"\n\n Total: "+str(Utils.score)
