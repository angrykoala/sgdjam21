extends RigidBody

var puntuacion=10

var nombre="Frankenfruta"
var frutas=["Manzana","Limon","Naranja","Cebolla","Platano"]
var codigo_fruta={"Manzana":0,"Limon":1,"Naranja":2,"Cebolla":3,"Platano":4}
onready var nodos_frutas={"Manzana":$Manzana,"Limon":$Limon,"Naranja":$Naranja,
	"Cebolla":$Cebolla,"Platano":$Platano}
var visibles_piezas=[null,null,null,null] setget mostrar_frankenfruta, get_visible

func get_visible():
	return visibles_piezas

# Called when the node enters the scene tree for the first time.
func _ready():
	# limpiar()
	#mostrar_frankenfruta(visibles)
	pass

func limpiar():
	for fruta in frutas:
		for nodo in nodos_frutas[fruta].get_children():
			nodo.visible=false
		# nodos_frutas[fruta].visible=false
		
func mostrar_frankenfruta(visibles_):
	var cuadrantes=["1_4AA","1_4A","1_4B","1_4BB"]
	
	for i in range(0,len(visibles_)):
		if visibles_[i]!=null:
			var visible=frutas[visibles_[i]]
			if visible!=null:
				var nodo=get_node(visible+"/"+visible+"-"+cuadrantes[i])
				nodo.visible=true
				nodo=get_node(visible)
				nodo.visible=true
				# print(visible+"/"+visible+"-"+cuadrantes[i])
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	pass
	#move_and_slide()
