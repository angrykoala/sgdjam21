extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var camera
var frutas=[]

var Etiqueta=preload("res://entities/HUD/Etiqueta.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	camera=get_viewport().get_camera()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for fruta in frutas:
		var pos=camera.unproject_position(fruta[0].get_global_transform().origin) 
		if fruta[1]!=null:
			fruta[1].set_global_position(pos)
		else:
			frutas.remove(fruta)
			
func _on_FrankenFruitsBase_fruta_creada(nodo_fruta):
	#var label=Etiqueta.instance()   # Label.new()
	# label.set_texto("+"+str(nodo_fruta.puntuacion))
	var label=Label.new()
	label.text="+"+str(nodo_fruta.puntuacion)
	self.add_child(label)
	frutas.append([nodo_fruta,label])

# vaya código mojón....
