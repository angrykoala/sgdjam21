extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var camera
var frutas=[]

# Called when the node enters the scene tree for the first time.
func _ready():
	camera=get_viewport().get_camera()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for fruta in frutas:
		var pos=camera.unproject_position(fruta[0].get_global_transform().origin) 
		fruta[1].set_global_position(pos)

func _on_FrankenFruitsBase_fruta_creada(nodo_fruta):
	var label=Label.new()
	self.add_child(label)
	label.text="+"+str(nodo_fruta.puntuacion)
	frutas.append([nodo_fruta,label])

# vaya código mojón....
