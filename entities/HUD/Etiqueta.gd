extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var tiempo_de_vida=3
var texto=""

func set_texto(texto_):
	$Label.text=texto_
	
# Called when the node enters the scene tree for the first time.
func _ready():
	set_texto(texto)
	$Timer.wait_time=tiempo_de_vida
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	queue_free ( )
