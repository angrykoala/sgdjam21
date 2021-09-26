extends Spatial


export(String, FILE) var main_menu_path

onready var results=$CanvasLayer/Panel/Label

func _on_ok_pressed() -> void:
	get_tree().change_scene(main_menu_path)

func _ready():
	var score=0

	for fruit in Utils.frankenfruits_list:
		var frankenfruit=fruit[0]
		var count=fruit[1]
		results.text=results.text+"\n"+str(count)+" x "+frankenfruit.nombre+" = "+str(count*frankenfruit.puntuation)
		score=score+count*frankenfruit.puntuation

	results.text=results.text+"\n\n Total: "+str(score)
