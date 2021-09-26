extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var label_time_to_live=5
var puntuacion=0
var camera
var frutas=[]

var Etiqueta=preload("res://entities/HUD/Etiqueta.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	camera=get_viewport().get_camera()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var now=OS.get_unix_time()

	for fruta in frutas:
		if now-fruta[2]<label_time_to_live:
			var pos=camera.unproject_position(fruta[0].get_global_transform().origin)
			if fruta[1]!=null:
				fruta[1].set_global_position(pos)
			else:
				frutas.remove(fruta)
		else:
			if fruta[1]!=null:
				fruta[1].queue_free()
				frutas.erase(fruta)

func _on_FrankenFruitsBase_fruta_creada(nodo_fruta):
	#var label=Etiqueta.instance()   # Label.new()
	# label.set_texto("+"+str(nodo_fruta.puntuacion))
	var label=Label.new()
	label.text="+"+str(nodo_fruta.puntuacion)+"\n"+nodo_fruta.nombre
	self.add_child(label)
	frutas.append([nodo_fruta,label,OS.get_unix_time()])


	puntuacion=puntuacion+nodo_fruta.puntuacion

	Utils.set_score(puntuacion)
	Utils.add_frankenfruit(nodo_fruta)
	mostrar_puntuacion(puntuacion)

func mostrar_puntuacion(puntuacion):
	$Score.text=str(puntuacion)+" points"
