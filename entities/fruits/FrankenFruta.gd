extends Spatial


var frutas=["Manzana","Limon","Naranja","Cebolla","Platano"]
onready var nodos_frutas={"Manzana":$Manzana,"Limon":$Limon,"Naranja":$Naranja,
	"Cebolla":$Cebolla,"Platano":$Platano}
export var visibles=[0,0,1,3]

# Called when the node enters the scene tree for the first time.
func _ready():
	limpiar()
	mostrar_frankenfruta(visibles)

func limpiar():
	for fruta in frutas:
		for nodo in nodos_frutas[fruta].get_children():
			nodo.visible=false
		nodos_frutas[fruta].visible=false
		
func mostrar_frankenfruta(visibles_):
	var cuadrantes=["1_4A","1_4AA","1_4B","1_4BB"]
	
	for i in range(0,len(visibles_)):
		var visible=frutas[visibles_[i]]
		if visible!=null:
			var nodo=get_node(visible+"/"+visible+"-"+cuadrantes[i])
			nodo.visible=true
			nodo=get_node(visible)
			nodo.visible=true
			print(visible+"/"+visible+"-"+cuadrantes[i])
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
